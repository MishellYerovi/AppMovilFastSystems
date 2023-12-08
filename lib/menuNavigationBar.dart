//import 'dart:js';

import 'package:fastsystems_app2/Administrador/editarInfoEmpresa.dart';
import 'package:fastsystems_app2/Administrador/logInAdmin.dart';
import 'package:fastsystems_app2/Administrador/menuAdministrador.dart';
import 'package:fastsystems_app2/Administrador/listarImagenesCarrusel.dart';
import 'package:fastsystems_app2/Administrador/subirNoticias.dart';
import 'package:fastsystems_app2/Modelo/leerPDF.dart';

import 'package:fastsystems_app2/home.dart';
import 'package:fastsystems_app2/menuConfiguraciones.dart';
import 'package:fastsystems_app2/menuOtrosServicios.dart';
import 'package:fastsystems_app2/playEntretenimiento.dart';
import 'package:fastsystems_app2/recomendaciones.dart';

import 'package:fastsystems_app2/ubicacion.dart';

import 'package:fastsystems_app2/webViewContainerUser.dart';
import 'package:fastsystems_app2/webViewContainerRouter.dart';
import 'package:flutter/material.dart';


import 'package:go_router/go_router.dart';

import 'Administrador/listarAdministradores.dart';
import 'about.dart';

import 'infoCuentaBanco.dart';
import 'mainwrapper.dart';
import 'menuServicios.dart';
late final bool focusedMarkerHighlight;



class AppNavigation {

  static String initial = "/home";

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorInicio =
  GlobalKey<NavigatorState>(debugLabel: 'shellInicio');
  static final _shellNavigatorAbout =
  GlobalKey<NavigatorState>(debugLabel: 'shellAbout');
  static final _shellNavigatorUbicacion =
  GlobalKey<NavigatorState>(debugLabel: 'shellUbicacion');
  //Administrador

  int banderaAdm=0;
  // GoRouter configuration
  static final GoRouter router2 = GoRouter(

      initialLocation: initial,
      debugLogDiagnostics: true,
      routes: [


  ]);

  static final GoRouter router = GoRouter(


    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [

      /// MainWrapper
      StatefulShellRoute.indexedStack(


        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[

          /// Branch Sobre Nosotros
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAbout,
            routes: <RouteBase>[

              GoRoute(
                path: "/about",
                name: "About",
               // builder: (BuildContext context, GoRouterState state) =>
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                // key: state.pageKey,

                maintainState: false,

                child: const AboutInfo(),
                transitionsBuilder:
                /*(context, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),*/
                    (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                  );
                }
                ),
                //const AboutInfo(),
                //AboutInfo(),

                /*routes: [
                  GoRoute(
                    path: "subSetting",
                    name: "subSetting",
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const SubSettingsView(),
                        transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                            ) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                ],*/
              ),
            ],
          ),

          /// Branch Home
          StatefulShellBranch(

            navigatorKey: _shellNavigatorInicio,
            routes: <RouteBase>[

              GoRoute(
                path: "/home",
                name: "Home",
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                  // key: state.pageKey,
                    maintainState: false,
                    child: const Home(),
                    transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
                        /*(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 1.0),
                          end: const Offset(0.0, 0.0),
                          //begin: const Offset(0.0, -1.0),
                          //end: const Offset(0.0, -1.0),
                        ).animate(animation),
                        child: child,
                      );*/
                    //}
                ),
              /* builder: (BuildContext context, GoRouterState state) =>
              const Home(),*/



               //Subrutas
               routes: [
                   //Subruta-CONFIGURACIONES-Router
                  GoRoute(
                    parentNavigatorKey:_shellNavigatorInicio,
                    path: 'homeConfiguraciones',
                    name: 'HomeConfiguraciones',
                      /*builder: (BuildContext context, GoRouterState state) {
                        return const menu_configuraciones(
                        ); },*/
                   pageBuilder: (context, state) => CustomTransitionPage<void>(
                    // key: state.pageKey,
                     maintainState: false,

                      child: const menu_configuraciones(),
                      transitionsBuilder:
                          /*(context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),*/
                          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: const Offset(0.0, 0.0),
                            //begin: const Offset(0.0, -1.0),
                            //end: const Offset(0.0, -1.0),
                          ).animate(animation),
                          child: child,
                        );
                      }
                    ),
                    //Subrutas de Cambiar contraseña
                    routes: [
                      //Cambiar Contraseña
                      GoRoute(
                        parentNavigatorKey:_shellNavigatorInicio,
                      path: 'homeRouterPage',
                      name: 'HomeRouterPage',

                     /* builder: (BuildContext context, GoRouterState state) {
                          final router= state.extra! as String;
                          return webViewContainerRouter(router); }*/
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        //key: state.pageKey,
                        maintainState: false,
                         // return webViewContainerRouter(router)
                      //router= state.extra! as String;
                        child:  webViewContainerRouter(state.extra.toString()),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),

                    ),

                    ],
                  ),
                 //Subruta Portal Usuarios
                 GoRoute(
                   parentNavigatorKey:_shellNavigatorInicio,
                   path: 'homeUsuarios',
                   name: 'HomeUsuarios',
                   pageBuilder: (context, state) => CustomTransitionPage<void>(
                     // key: state.pageKey,
                     maintainState: false,
                     child: const webViewContainer(),
                     transitionsBuilder:
                         (context, animation, secondaryAnimation, child) =>
                         FadeTransition(opacity: animation, child: child),
                   ),
                 ),
                 //Subruta Servicios
                 GoRoute(
                   parentNavigatorKey:_shellNavigatorInicio,
                   path: 'homeServicios',
                   name: 'HomeServicios',
                   pageBuilder: (context, state) => CustomTransitionPage<void>(
                     // key: state.pageKey,
                     maintainState: false,
                     child: const menuServicios(),
                     transitionsBuilder:
                         (context, animation, secondaryAnimation, child) =>
                         FadeTransition(opacity: animation, child: child),
                         /*(context, animation, secondaryAnimation, child) =>
                         ScaleTransition(
                           scale: animation,
                           child: child,
                         ),*/
                   ),
                     routes: [
                       GoRoute(
                         parentNavigatorKey:_shellNavigatorInicio,
                         path: 'homeServiciosInfoPagos',
                         name: 'HomeServiciosInfoPagos',
                         pageBuilder: (context, state) => CustomTransitionPage<void>(
                           // key: state.pageKey,
                           maintainState: false,
                          child: cInfoCuentaBanco(),
                          // child:cLeerPdf(),
                         //  child: cRecomendaciones(),
                        // child: const MenuOtrosServicios(),
                           transitionsBuilder:
                               (context, animation, secondaryAnimation, child) =>
                               FadeTransition(opacity: animation, child: child),

                         ),
                       ),
                       GoRoute(
                         parentNavigatorKey:_shellNavigatorInicio,
                         path: 'homeServiciosRecomendaciones',
                         name: 'HomeServiciosRecomendaciones',
                         pageBuilder: (context, state) => CustomTransitionPage<void>(
                           // key: state.pageKey,
                           maintainState: false,
                           //child: cInfoCuentaBanco(),
                           // child:cLeerPdf(),
                           child: cRecomendaciones(),
                           // child: const MenuOtrosServicios(),
                           transitionsBuilder:
                               (context, animation, secondaryAnimation, child) =>
                               FadeTransition(opacity: animation, child: child),

                         ),
                       ),
                     ]
                 ),
                 //Subruta Otros servicios
                /*GoRoute(
                   parentNavigatorKey:_shellNavigatorInicio,
                   path: 'homeOtrosServicios',
                   name: 'HomeOtrosServicios',
                   pageBuilder: (context, state) => CustomTransitionPage<void>(
                     // key: state.pageKey,
                     maintainState: false,
                   child: playLinkEntretenimiento(),
                    // child: const MenuOtrosServicios(),
                     transitionsBuilder:
                         (context, animation, secondaryAnimation, child) =>
                         FadeTransition(opacity: animation, child: child),

                   ),
                 ),*/

                 GoRoute(
                   parentNavigatorKey:_shellNavigatorInicio,
                   path: 'homeLogInAdministrador',
                   name: 'HomeLogInAdministrador',
                   pageBuilder: (context, state) => CustomTransitionPage<void>(
                     // key: state.pageKey,
                     maintainState: false,
                     child: const logInAdmin(),
                          //const EditarInformacionEmpresa(),
                     transitionsBuilder:
                        /* (context, animation, secondaryAnimation, child) =>
                         FadeTransition(opacity: animation, child: child),*/
                         /*(context, animation, secondaryAnimation, child) =>
                             ScaleTransition(
                               scale: animation,
                               child: child,
                             ),
                        */
                         (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                       return SlideTransition(
                         position: Tween<Offset>(
                           begin: const Offset(1.0, 0.0),
                           end: const Offset(0.0, 0.0),
                         ).animate(animation),
                         child: child,
                       );
                     }

                        // SlideTransition(position: Offset(0.0, 1.0), child: Container(color: Colors.blue),),
                     /*{
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;
                          var tween=Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                           return  animation.drive(tween);
                          },*/

                   ),

                   routes: [
                     GoRoute(
                       parentNavigatorKey:_shellNavigatorInicio,
                       path: 'homeAdminMenu',
                       name: 'HomeAdminMenu',

                       /* builder: (BuildContext context, GoRouterState state) {
                          final router= state.extra! as String;
                          return webViewContainerRouter(router); }*/
                       pageBuilder: (context, state) =>
                           CustomTransitionPage<void>(
                             //key: state.pageKey,
                             maintainState: false,
                             // return webViewContainerRouter(router)
                             //router= state.extra! as String;
                             child: const menuAdministrador(),
                             //const subirNoticias(),
                             transitionsBuilder:
                                /* (context, animation, secondaryAnimation, child) =>
                                 FadeTransition(opacity: animation, child: child),*/
                                 /*(context, animation, secondaryAnimation, child) =>
                                 ScaleTransition(
                                   scale: animation,
                                   child: child,
                                 ),*/

                                (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                return SlideTransition(
                                position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: const Offset(0.0, 0.0),
                                ).animate(animation),
                                  child: child,
                                );
                                  }
                           ),

                   routes: [
                                GoRoute(
                                  parentNavigatorKey:_shellNavigatorInicio,
                                  path: 'homeEditarInfoEmpresa',
                                  name: 'HomeEditarInfoEmpresa',

                                  /* builder: (BuildContext context, GoRouterState state) {
                                                          final router= state.extra! as String;
                                                          return webViewContainerRouter(router); }*/
                                  pageBuilder: (context, state) =>
                                  CustomTransitionPage<void>(
                                  //key: state.pageKey,
                                  maintainState: false,
                                  // return webViewContainerRouter(router)
                                  //router= state.extra! as String;
                                  child: const editarInformacionEmpresa(),
                                  //const subirNoticias(),
                                  transitionsBuilder:
                                 /* (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(opacity: animation, child: child),*/
                                      (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
                                        end: const Offset(0.0, 0.0),
                                        //begin: const Offset(0.0, -1.0),
                                        //end: const Offset(0.0, -1.0),
                                      ).animate(animation),
                                      child: child,
                                    );
                                  }

                                  ),
                                  ),
                                     //SUBIR NOTICIAS
                                     GoRoute(
                                       parentNavigatorKey:_shellNavigatorInicio,
                                       path: 'homeGuardarNoticias',
                                       name: 'HomeGuardarNoticias',

                                       /* builder: (BuildContext context, GoRouterState state) {
                                                                      final router= state.extra! as String;
                                                                      return webViewContainerRouter(router); }*/
                                       pageBuilder: (context, state) =>
                                           CustomTransitionPage<void>(
                                             //key: state.pageKey,
                                             maintainState: false,
                                             // return webViewContainerRouter(router)
                                             //router= state.extra! as String;
                                             child: const guardarNoticias(),
                                             //const subirNoticias(),
                                             transitionsBuilder:
                                                /* (context, animation, secondaryAnimation, child) =>
                                                 FadeTransition(opacity: animation, child: child),*/
                                                /* (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                               return SlideTransition(
                                                 position: Tween<Offset>(
                                                   begin: const Offset(0.0, 1.0),
                                                   end: const Offset(0.0, 0.0),
                                                   //begin: const Offset(0.0, -1.0),
                                                   //end: const Offset(0.0, -1.0),
                                                 ).animate(animation),
                                                 child: child,
                                               );
                                             }*/
                                                 (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                               return SlideTransition(
                                                 position: Tween<Offset>(
                                                   begin: const Offset(1.0, 0.0),
                                                   end: const Offset(0.0, 0.0),
                                                   //begin: const Offset(0.0, -1.0),
                                                   //end: const Offset(0.0, -1.0),
                                                 ).animate(animation),
                                                 child: child,
                                               );
                                             }
                                           ),
                                     ),
                                  //Obtener Noticias
                                     GoRoute(
                                       parentNavigatorKey:_shellNavigatorInicio,
                                       path: 'homeListarNoticias',
                                       name: 'HomeListarNoticias',

                                       /* builder: (BuildContext context, GoRouterState state) {
                                                                                  final router= state.extra! as String;
                                                                                  return webViewContainerRouter(router); }*/
                                       pageBuilder: (context, state) =>
                                           CustomTransitionPage<void>(
                                             //key: state.pageKey,
                                             maintainState: false,
                                             // return webViewContainerRouter(router)
                                             //router= state.extra! as String;
                                             child: const listarNoticias(),
                                             //const subirNoticias(),
                                             transitionsBuilder:
                                                 (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                               return SlideTransition(
                                                 position: Tween<Offset>(
                                                   begin: const Offset(1.0, 0.0),
                                                   end: const Offset(0.0, 0.0),
                                                   //begin: const Offset(0.0, -1.0),
                                                   //end: const Offset(0.0, -1.0),
                                                 ).animate(animation),
                                                 child: child,
                                               );
                                             }
                                                 /*(context, animation, secondaryAnimation, child) =>
                                                 FadeTransition(opacity: animation, child: child),*/
                                           ),
                                     ),
                                     //Obtener Administradores
                                     GoRoute(
                                       parentNavigatorKey:_shellNavigatorInicio,
                                       path: 'homeListarAdministradores',
                                       name: 'HomeListarAdministradores',

                                       /* builder: (BuildContext context, GoRouterState state) {
                                                                                                  final router= state.extra! as String;
                                                                                                  return webViewContainerRouter(router); }*/
                                       pageBuilder: (context, state) =>
                                           CustomTransitionPage<void>(
                                             //key: state.pageKey,
                                             maintainState: false,
                                             // return webViewContainerRouter(router)
                                             //router= state.extra! as String;
                                             child: const cListarAdministradores(),
                                             //const subirNoticias(),
                                             transitionsBuilder:
                                                 (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                               return SlideTransition(
                                                 position: Tween<Offset>(
                                                   begin: const Offset(1.0, 0.0),
                                                   end: const Offset(0.0, 0.0),
                                                   //begin: const Offset(0.0, -1.0),
                                                   //end: const Offset(0.0, -1.0),
                                                 ).animate(animation),
                                                 child: child,
                                               );
                                             }
                                               /* (context, animation, secondaryAnimation, child) =>
                                                 FadeTransition(opacity: animation, child: child),*/
                                           ),
                                     ),
                              ]
                       ,

                     ),
                   ],
                 ),
                ],
              ),
            ],
          ),

          /// Branch Ubicación
          StatefulShellBranch(

            navigatorKey: _shellNavigatorUbicacion,
            routes: <RouteBase>[
              GoRoute(
                parentNavigatorKey:_shellNavigatorUbicacion,
                path: "/ubicacion",
                name: "ubicacion",
                builder: (BuildContext context, GoRouterState state) =>
                   const Ubicacion(),
                    //MainExample(focusedLocation: GeoPoint( latitude: 51.2408822, longitude: 22.5449109), focusedMarkerHighlight: false ) ,
                /*
                routes: [

                  GoRoute(
                    parentNavigatorKey:_shellNavigatorUbicacion,
                    path: 'homeConfiguraciones',
                    name: 'homeConfiguraciones',
                    /*builder: (BuildContext context, GoRouterState state) {
                        return const menu_configuraciones(
                        ); },*/
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      // key: state.pageKey,
                      // maintainState: false,
                      child: const menu_configuraciones(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                    routes: [

                      GoRoute(
                          parentNavigatorKey:_shellNavigatorUbicacion,
                          path: 'homeRouterPage',
                          name: 'homeRouterPage',

                          // onExit:(BuildContext context, GoRouterState state) => "/home",
                          /* builder: (BuildContext context, GoRouterState state) {
                          final router= state.extra! as String;
                          return webViewContainerRouter(router); }*/
                          pageBuilder: (context, state) =>
                              CustomTransitionPage<void>(
                                // key: state.pageKey,
                                // maintainState: true,
                                // return webViewContainerRouter(router)
                                //router= state.extra! as String;
                                child:  webViewContainerRouter(state.extra.toString()),
                                transitionsBuilder:
                                    (context, animation, secondaryAnimation, child) =>
                                    FadeTransition(opacity: animation, child: child),
                              )
                        /*redirect: (BuildContext context, GoRouterState state) => "/home",*/
                      ),],
                  ),


                ],*/
              ),
            ],
          ),

        ],
      ),
/*
      /// Player
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/player',
        name: "Player",
        builder: (context, state) => PlayerView(
          key: state.pageKey,
        ),
      )*/
    ],

  );

  AppNavigation(int bandera)
  {
    banderaAdm=bandera;
  }

  /*void clearStackAndNavigate(BuildContext context, String path) {

  }*/

}