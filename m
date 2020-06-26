Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36077 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgFZCyO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Jun 2020 22:54:14 -0400
Date: Fri, 26 Jun 2020 02:54:10 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
Message-ID: <20200626025410.GJ4332@42.do-not-panic.com>
References: <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624144311.GA5839@infradead.org>
 <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
 <20200624160953.GH4332@42.do-not-panic.com>
 <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
 <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
 <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>

On Wed, Jun 24, 2020 at 08:37:55PM +0200, Christian Borntraeger wrote:
> 
> 
> On 24.06.20 20:32, Christian Borntraeger wrote:
> [...]> 
> > So the translations look correct. But your change is actually a sematic change
> > if(ret) will only trigger if there is an error
> > if (KWIFEXITED(ret)) will always trigger when the process ends. So we will always overwrite -ECHILD
> > and we did not do it before. 
> > 
> 
> So the right fix is
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index f81e8698e36e..a3a3196e84d1 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -154,7 +154,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
>                  * the real error code is already in sub_info->retval or
>                  * sub_info->retval is 0 anyway, so don't mess with it then.
>                  */
> -               if (KWIFEXITED(ret))
> +               if (KWEXITSTATUS(ret))
>                         sub_info->retval = KWEXITSTATUS(ret);
>         }
>  
> I think.

Nope, the right form is to check for WIFEXITED() before using WEXITSTATUS().
I'm not able to reproduce this on x86 with a bridge. What type of bridge
are you using on a guest, or did you mean using KVM so that the *host*
can spawn kvm guests?

It would be good if you can try to add a bridge manually and see where
things fail. Can you do something like this:

brctl addbr br0
brctl addif br0 ens6 
ip link set dev br0 up

Note that most callers are for modprobe. I'd be curious to see which
umh is failing which breaks bridge for you. Can you trut this so we can
see which umh call is failing?

diff --git a/kernel/umh.c b/kernel/umh.c
index f81e8698e36e..5ad74bc301d8 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -2,6 +2,9 @@
 /*
  * umh - the kernel usermode helper
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -154,8 +157,12 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 		 * the real error code is already in sub_info->retval or
 		 * sub_info->retval is 0 anyway, so don't mess with it then.
 		 */
-		if (KWIFEXITED(ret))
+		printk("== ret: %02x\n", ret);
+		printk("== KWIFEXITED(ret): %02x\n", KWIFEXITED(ret));
+		if (KWIFEXITED(ret)) {
+			printk("KWEXITSTATUS(ret): %d\n", KWEXITSTATUS(ret));
 			sub_info->retval = KWEXITSTATUS(ret);
+		}
 	}
 
 	/* Restore default kernel sig handler */
@@ -383,6 +390,7 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
 		void *data)
 {
 	struct subprocess_info *sub_info;
+	unsigned int i = 0;
 	sub_info = kzalloc(sizeof(struct subprocess_info), gfp_mask);
 	if (!sub_info)
 		goto out;
@@ -394,6 +402,11 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
 #else
 	sub_info->path = path;
 #endif
+	pr_info("sub_info->path: %s\n", sub_info->path);
+	while (argv[i])
+		printk(KERN_INFO "%s ", argv[i++]);
+	printk(KERN_INFO  "\n");
+
 	sub_info->argv = argv;
 	sub_info->envp = envp;
 
