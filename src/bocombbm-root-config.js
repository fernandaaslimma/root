import { registerApplication, start } from "single-spa";

async function loadAppWithFallback(name, url) {
  try {
    return await System.import(url);
  } catch (error) {
    console.error(`Erro ao carregar o aplicativo ${name}: ${error.message}`);
    return null;
  }
}

const appsConfig = [
  {
    name: "@bocombbm/mf-ib",
    url: "@bocombbm/mf-ib",
    activeWhen: "/",
  },
];

const appsPromises = appsConfig.map((appConfig) => {
  return loadAppWithFallback(appConfig.name, appConfig.url);
});

Promise.all(appsPromises).then((apps) => {
  apps.forEach((app, index) => {
    if (app) {
      registerApplication({
        name: appsConfig[index].name,
        app,
        activeWhen: () =>
          location.pathname.startsWith(appsConfig[index].activeWhen),
      });
    }
  });

  start();
});
