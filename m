From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Date: Tue, 4 Sep 2018 09:45:47 -0600
Message-ID: <cab5289c-7c53-28a8-b9b2-0c55c9f8d968@kernel.dk>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/dri-devel/>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
To: Henrik Austad <henrik@austad.us>, linux-doc@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, Jan Kandziora <jjj@gmx.de>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Henrik Austad <haustad@cisco.com>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-s390@vger.kernel.org, Ian Kent <raven@themaw.net>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>
List-ID: <linux-s390.vger.kernel.org>

On 9/3/18 4:15 PM, Henrik Austad wrote:
> This is a respin with a wider audience (all that get_maintainer returned)
> and I know this spams a *lot* of people. Not sure what would be the correct
> way, so my apologies for ruining your inbox.
> 
> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question. Often a simple "ls" would reveal
> the same information as the filenames are generally quite descriptive as
> a short introduction to what the file covers (it should not surprise
> anyone what Documentation/sched/sched-design-CFS.txt covers)
> 
> A few years back it was mentioned that these files were no longer really
> needed, and they have since then grown further out of date, so perhaps
> it is time to just throw them out.
> 
> A short status yields the following _outdated_ 00-INDEX files, first
> counter is files listed in 00-INDEX but missing in the directory, last
> is files present but not listed in 00-INDEX.

For the block related bits:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
