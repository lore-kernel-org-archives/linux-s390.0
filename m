Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [RFC PATCH] drivers/base: use cpu->node_id for from_nid
Date: Thu, 30 Jul 2015 20:35:51 +0200
Message-Id: <1438281351-56556-1-git-send-email-holzheu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Greg,

Is it possible to use "from_nid = cpu->node_id"?

Background:

I am currently working on (fake) NUMA support for s390. At startup, for
"deconfigured" CPUs, we don't know to which nodes the CPUs belong. Therefore
we always return node 0 for cpu_to_node().

For each present CPU the register_cpu() function is called which sets an
initial NUMA node via cpu_to_node(), which is then first node 0 for
"deconfigured" CPUs on s390.

After we "configure" a CPU we know to which node it belongs. Then when setting
a CPU online, the following is done in cpu_subsys_online():

     from_nid = cpu_to_node(cpuid); -> we return node x
     cpu_up(cpuid);
     to_nid = cpu_to_node(cpuid);   -> we return node x
     if (from_nid != to_nid)        -> x != x -> false
           change_cpu_under_node(cpu, from_nid, to_nid);

The result is that each CPU that was deconfigured at boot time stays in
node 0 because cpu_to_node() returns the same node before and after
setting the CPU online.

Using "cpu->node_id" for "from_nid" instead of calling cpu_to_node()
would help in our case.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index f160ea4..2dd889c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -47,7 +47,7 @@ static int __ref cpu_subsys_online(struct device *dev)
 	int from_nid, to_nid;
 	int ret;
 
-	from_nid = cpu_to_node(cpuid);
+	from_nid = cpu->node_id;
 	if (from_nid == NUMA_NO_NODE)
 		return -ENODEV;
 
-- 
2.3.8
