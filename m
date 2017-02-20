From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/4] x86: convert threshold_bank.cpus from atomic_t to
 refcount_t
Date: Mon, 20 Feb 2017 12:17:27 +0100
Message-ID: <20170220111727.7vohleiu2btmsx3g@pd.tnic>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
 <1487588781-15123-3-git-send-email-elena.reshetova@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487588781-15123-3-git-send-email-elena.reshetova@intel.com>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 20, 2017 at 01:06:19PM +0200, Elena Reshetova wrote:
> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.
> 
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>

That SOB chain tells me that you wrote the patch and Hans, Kees and
David handled it in some way and the last one - David - is sending it to
me. It doesn't look like that though.

So what are you trying to express with it?

Documentation/process/submitting-patches.rst has some info on the whole
SOB deal:

11) Sign your work — the Developer's Certificate of Origin
----------------------------------------------------------
..


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
