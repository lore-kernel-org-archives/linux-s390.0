From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
Date: Fri, 26 Apr 2019 09:22:34 -0400
Message-ID: <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
References: <20190426130736.GB8646@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426130736.GB8646@osiris>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Jessica Yu <jeyu@kernel.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Cathy Avery <cavery@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 4/26/19 9:07 AM, Heiko Carstens wrote:
> Hello Prarit,
> 
> it looks like your commit f9a75c1d717f ("modules: Only return -EEXIST
> for modules that have finished loading") _sometimes_ causes hangs on
> s390. This is unfortunately not 100% reproducible, however the
> mentioned commit seems to be the only relevant one in modules.c.
> 
> What I see is a hanging system with messages like this on the console:
> 
> [   65.876040] rcu: INFO: rcu_sched self-detected stall on CPU
> [   65.876049] rcu:     7-....: (5999 ticks this GP) idle=eae/1/0x4000000000000002 softirq=1181/1181 fqs=2729
> [   65.876078]  (t=6000 jiffies g=-471 q=17196)
> [   65.876084] Task dump for CPU 7:
> [   65.876088] systemd-udevd   R  running task        0   731    721 0x06000004
> [   65.876097] Call Trace:
> [   65.876113] ([<0000000000abb264>] __schedule+0x2e4/0x6e0)
> [   65.876122]  [<00000000001ee486>] finished_loading+0x4e/0xb0
> [   65.876128]  [<00000000001f1ed6>] load_module+0xcce/0x27a0
> [   65.876134]  [<00000000001f3af0>] __s390x_sys_init_module+0x148/0x178
> [   65.876142]  [<0000000000ac0766>] system_call+0x2aa/0x2c8
> 
> crash's backtrace of this task looks like this:
> 
> PID: 731    TASK: 1e79ba000         CPU: 7   COMMAND: "systemd-udevd"
>  LOWCORE INFO:
>   -psw      : 0x0704c00180000000 0x0000000000ab666a
>   -function : memcmp at ab666a
>   -prefix   : 0x7fe32000
>   -cpu timer: 0x7fffff5784d0f048
>   -clock cmp: 0xd60757081cd70d00
>   -general registers:
>      0x0000000000000009 0x0000000000000009
>      0x000003ff80347321 000000000000000000
>      0x000003ff8034f321 000000000000000000
>      0x000000000000001e 0x000003ff8c592708
>      0x000003e0047da900 0x000003ff8034f318
>      0x0000000000000001 0x0000000000000009
>      0x000003ff80347300 0x0000000000ad81b8
>      0x00000000001ee062 0x000003e004357cb0
> [...]
>  #0 [3e004357cf0] load_module at 1f1eb0
>  #1 [3e004357dd0] __se_sys_init_module at 1f3af0
>  #2 [3e004357ea8] system_call at ac0766
>  PSW:  0705000180000000 000003ff8c27ad3e (user space)
>  GPRS: 000002aa280d2fb0 000003ff8c27ad3c 0000000000000080 00000000000035fd
>        000003ff8c592708 000002aa280c8770 0000000000000000 000002aa280d7130
>        0000000000020000 000002aa28915760 000003ff8c592708 000002aa280c00b0
>        000003ff8c8fff80 000002aa280c00b0 000003ff8c58a456 000003ffe9cfde90
> 
> I did not look any further into the dump, however since the commit
> touches exactly the code path which seems to be looping... ;)
> 

Ouch :(  I wonder if I exposed a further race or another bug.  Heiko, can you
determine which module is stuck?  Warning: I have not compiled this code.

diff --git a/kernel/module.c b/kernel/module.c
index e8c1de2ab4e1..bd5eebc95049 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3567,6 +3567,8 @@ static int add_unformed_module(struct module *mod)
 	old = find_module_all(mod->name, strlen(mod->name), true);
 	if (old != NULL) {
 		if (old->state != MODULE_STATE_LIVE) {
+			printk_ratelimited("PRARIT: waiting for module %s to load.\n",
+					   mod->name);
 			/* Wait in case it fails to load. */
 			mutex_unlock(&module_mutex);
 			err = wait_event_interruptible(module_wq,
@@ -3575,6 +3577,8 @@ static int add_unformed_module(struct module *mod)
 				goto out_unlocked;
 			goto again;
 		}
+		printk("PRARIT: module %s already exists.\n",
+		       mod->name);
 		err = -EEXIST;
 		goto out;
 	}

P.
