Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/30] perf tests: Add platform dependency to test 15
Date: Fri, 30 Jun 2017 19:24:45 -0300
Message-Id: <20170630222514.11832-2-acme@kernel.org>
In-Reply-To: <20170630222514.11832-1-acme@kernel.org>
References: <20170630222514.11832-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

This patch adds platform dependency into the test case 15
(perf_event_attr). It is based on a suggestion from Jiri Olsa.

Add a new optional attribute named 'arch' in the [config] section of the
test case file. It is a comma separated list of architecture names this
test can be executed on. For example:

  arch = x86_64,alpha,ppc

If this attribute is missing the test is executed on any platform.  This
does not break existing behavior.

The values listed for this attribute should be identical to uname -m
output.

If the list starts with an exclamation mark (!) the comparison is
inverted, for example for

  arch = !s390x,ppc

the test is not executed on s390x or ppc platforms.  The exclamation
mark must be at the beginnning of the list.

Here is an example debug output:

  [root@s35lp76]# fgrep arch tests/attr/test-stat-C2
  arch = x86_64,alpha,ppc
  [root@s35lp76]# PERF_TEST_ATTR=/tmp /usr/bin/python2 ./tests/attr.py \
    -d ./tests/attr/ -p ./perf -vvvvv -t test-stat-C1

provides the following output:

  running './tests/attr//test-stat-C1'
  test limitation 'x86_64,alpha,ppc' <--- new
    loading expected events
      Event event:base-stat
        fd = 1
        group_fd = -1
        .....

Here is the output when a test is skipped:

  [root@s35lp76]# fgrep arch tests/attr/test-stat-C1
  arch = !s390x
  [root@s35lp76]# PERF_TEST_ATTR=/tmp /usr/bin/python2 ./tests/attr.py \
    -d ./tests/attr/ -p ./perf -vvvvv -t test-stat-C1

provides the following output:

test limitation '!s390x' <--- new

skipped [s390x] './tests/attr//test-stat-C1' <--- new

The test is skipped with return code 0.

Suggested-and-Acked-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
Link: http://lkml.kernel.org/r/20170622073625.86762-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.py | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 1091bd47adfd..cdf21a9d0c35 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -16,6 +16,13 @@ class Fail(Exception):
     def getMsg(self):
         return '\'%s\' - %s' % (self.test.path, self.msg)
 
+class Notest(Exception):
+    def __init__(self, test, arch):
+        self.arch = arch
+        self.test = test
+    def getMsg(self):
+        return '[%s] \'%s\'' % (self.arch, self.test.path)
+
 class Unsup(Exception):
     def __init__(self, test):
         self.test = test
@@ -112,6 +119,9 @@ class Event(dict):
 #     'command' - perf command name
 #     'args'    - special command arguments
 #     'ret'     - expected command return value (0 by default)
+#     'arch'    - architecture specific test (optional)
+#                 comma separated list, ! at the beginning
+#                 negates it.
 #
 # [eventX:base]
 #   - one or multiple instances in file
@@ -134,6 +144,12 @@ class Test(object):
         except:
             self.ret  = 0
 
+        try:
+            self.arch  = parser.get('config', 'arch')
+            log.warning("test limitation '%s'" % self.arch)
+        except:
+            self.arch  = ''
+
         self.expect   = {}
         self.result   = {}
         log.debug("  loading expected events");
@@ -145,6 +161,31 @@ class Test(object):
         else:
             return True
 
+    def skip_test(self, myarch):
+        # If architecture not set always run test
+        if self.arch == '':
+            # log.warning("test for arch %s is ok" % myarch)
+            return False
+
+        # Allow multiple values in assignment separated by ','
+        arch_list = self.arch.split(',')
+
+        # Handle negated list such as !s390x,ppc
+        if arch_list[0][0] == '!':
+            arch_list[0] = arch_list[0][1:]
+            log.warning("excluded architecture list %s" % arch_list)
+            for arch_item in arch_list:
+                # log.warning("test for %s arch is %s" % (arch_item, myarch))
+                if arch_item == myarch:
+                    return True
+            return False
+
+        for arch_item in arch_list:
+            # log.warning("test for architecture '%s' current '%s'" % (arch_item, myarch))
+            if arch_item == myarch:
+                return False
+        return True
+
     def load_events(self, path, events):
         parser_event = ConfigParser.SafeConfigParser()
         parser_event.read(path)
@@ -168,6 +209,11 @@ class Test(object):
             events[section] = e
 
     def run_cmd(self, tempdir):
+        junk1, junk2, junk3, junk4, myarch = (os.uname())
+
+        if self.skip_test(myarch):
+            raise Notest(self, myarch)
+
         cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
               self.perf, self.command, tempdir, self.args)
         ret = os.WEXITSTATUS(os.system(cmd))
@@ -265,6 +311,8 @@ def run_tests(options):
             Test(f, options).run()
         except Unsup, obj:
             log.warning("unsupp  %s" % obj.getMsg())
+        except Notest, obj:
+            log.warning("skipped %s" % obj.getMsg())
 
 def setup_log(verbose):
     global log
-- 
2.9.4
