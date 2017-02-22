From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/4] x86: convert threshold_bank.cpus from atomic_t to
 refcount_t
Date: Wed, 22 Feb 2017 10:27:48 +0100
Message-ID: <20170222092638.GA9953@nazgul.tnic>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
 <1487588781-15123-3-git-send-email-elena.reshetova@intel.com>
 <20170220111727.7vohleiu2btmsx3g@pd.tnic>
 <CAGXu5j+qpZy1sdMQJU5GrMF3NBZt7Wra55c59EiwT+WGEA_hBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5j+qpZy1sdMQJU5GrMF3NBZt7Wra55c59EiwT+WGEA_hBw@mail.gmail.com>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 21, 2017 at 12:45:30PM -0800, Kees Cook wrote:
> On Mon, Feb 20, 2017 at 3:17 AM, Borislav Petkov <bp@alien8.de> wrote:
> > On Mon, Feb 20, 2017 at 01:06:19PM +0200, Elena Reshetova wrote:
> >> refcount_t type and corresponding API should be
> >> used instead of atomic_t when the variable is used as
> >> a reference counter. This allows to avoid accidental
> >> refcounter overflows that might lead to use-after-free
> >> situations.
> >>
> >> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> >> Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> Signed-off-by: David Windsor <dwindsor@gmail.com>
> >
> > That SOB chain tells me that you wrote the patch and Hans, Kees and
> > David handled it in some way and the last one - David - is sending it to
> > me. It doesn't look like that though.
> 
> Perhaps the least inaccurate form of this might be:
> 
> 
> Inspired by atomic protections in PaX/grsecurity.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> 
> 
> As this is something I'd suggested we implement based on the work in
> PaX/grsecurity, David took the first (and continuing) stab at
> conversions, Hans did more, and Elena has been doing even more along
> with the heavy-lifting of keeping the series organized. That way the
> first SoB is still the author, the last SoB is still the email sender,
> and everyone's name is mentioned.
> 
> Or just:
> 
> 
> Inspired by atomic protections in PaX/grsecurity, based on work from
> David Windsor, Hans Liljestrand, and myself.
> 
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> 
> 
> I'm not picky -- I just want to see the conversion to refcount_t

Me neither - both look good to me and actually explain what the SOB
chain was trying to say.

Thanks!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
