Return-Path: <pmladek@suse.com>
Date: Fri, 16 Dec 2016 17:55:55 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 11/15] livepatch: use kstrtobool() in enabled_store()
Message-ID: <20161216165555.GK393@pathway.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <50c4817cbccd6e6cfd0c85c96bf127f84ee79cc8.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50c4817cbccd6e6cfd0c85c96bf127f84ee79cc8.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-12-08 12:08:36, Josh Poimboeuf wrote:
> The sysfs enabled value is a boolean, so kstrtobool() is a better fit
> for parsing the input string since it does the range checking for us.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  kernel/livepatch/core.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 6a137e1..8ca8a0e 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -408,26 +408,23 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
>  {
>  	struct klp_patch *patch;
>  	int ret;
> -	unsigned long val;
> +	bool enabled;
>  
> -	ret = kstrtoul(buf, 10, &val);
> +	ret = kstrtobool(buf, &enabled);
>  	if (ret)
>  		return -EINVAL;

I would return "ret" here. It is -EINVAL as well but... ;-)

Anyway, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
