--- src/misc/misc.c.orig	2004-04-13 05:49:04.000000000 -0700
+++ src/misc/misc.c	2014-06-21 02:32:50.000000000 -0700
@@ -101,7 +101,7 @@
 }
 
 /* ---------------------------------------------------------------------- */
-
+#ifndef FBSD_HAS_LOG2
 /*
  * Integer base-2 logarithm
  */
@@ -118,7 +118,7 @@
 
 	return y;
 }
-
+#endif
 /* ---------------------------------------------------------------------- */
 
 /*
