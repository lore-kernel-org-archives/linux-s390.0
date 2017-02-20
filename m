From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/4] s390: convert debug_info.ref_count from atomic_t to
 refcount_t
Date: Mon, 20 Feb 2017 14:34:31 +0100
Message-ID: <20170220133431.GB5656@osiris>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
 <1487588781-15123-2-git-send-email-elena.reshetova@intel.com>
 <20170220132424.GA5656@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170220132424.GA5656@osiris>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Elena Reshetova <elena.reshetova@intel.com>, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 20, 2017 at 02:24:24PM +0100, Heiko Carstens wrote:
> > @@ -361,7 +361,7 @@ debug_info_create(const char *name, int pages_per_area, int nr_areas,
> >          debug_area_last = rc;
> >          rc->next = NULL;
> >  
> > -	debug_info_get(rc);
> > +	refcount_set(&rc->ref_count, 1);
> 
> This is not wrong, but I will remove this hunk before applying your patch,
> since this doesn't look like an obvious correct change at first glance.

Actually your version is needed - just looked at refcount_inc().
Sorry for the confusion in my side now.
