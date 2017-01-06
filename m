Return-Path: <jpoimboe@redhat.com>
Date: Fri, 6 Jan 2017 15:04:11 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 15/15] livepatch: allow removal of a disabled patch
Message-ID: <20170106210411.er57shthgit7bqx3@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <21cb19ed5a44e876aeb830fdea1fad2c795a63f5.1481220077.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1701041554270.6852@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LSU.2.20.1701041554270.6852@pobox.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 04, 2017 at 03:57:09PM +0100, Miroslav Benes wrote:
> 
> > diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
> > index bb61c65..0625f38 100644
> > --- a/samples/livepatch/livepatch-sample.c
> > +++ b/samples/livepatch/livepatch-sample.c
> > @@ -89,7 +89,6 @@ static int livepatch_init(void)
> >  
> >  static void livepatch_exit(void)
> >  {
> > -	WARN_ON(klp_disable_patch(&patch));
> >  	WARN_ON(klp_unregister_patch(&patch));
> >  }
> 
> Btw, we remove the only call to klp_disable_patch() here. Maybe we can 
> remove the function completely. It is not needed anywhere.

Maybe so.  I haven't heard of anybody needing this interface.

-- 
Josh
