Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH 1/3] [S390] vmur: convert urdev.ref_count from atomic_t
 to refcount_t
Date: Fri, 27 Oct 2017 06:35:35 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B802B69F2@IRSMSX102.ger.corp.intel.com>
References: <1508485670-24070-1-git-send-email-elena.reshetova@intel.com>
        <1508485670-24070-2-git-send-email-elena.reshetova@intel.com>
 <20171026083449.57ccb533@mschwideX1>
In-Reply-To: <20171026083449.57ccb533@mschwideX1>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "jwi@linux.vnet.ibm.com" <jwi@linux.vnet.ibm.com>, "ubraun@linux.vnet.ibm.com" <ubraun@linux.vnet.ibm.com>, "peterz@infradead.org" <peterz@infradead.org>, "keescook@chromium.org" <keescook@chromium.org>
List-ID: <linux-s390.vger.kernel.org>


> On Fri, 20 Oct 2017 10:47:48 +0300
> Elena Reshetova <elena.reshetova@intel.com> wrote:
> 
> > atomic_t variables are currently used to implement reference
> > counters with the following properties:
> >  - counter is initialized to 1 using atomic_set()
> >  - a resource is freed upon counter reaching zero
> >  - once counter reaches zero, its further
> >    increments aren't allowed
> >  - counter schema uses basic atomic operations
> >    (set, inc, inc_not_zero, dec_and_test, etc.)
> >
> > Such atomic variables should be converted to a newly provided
> > refcount_t type and API that prevents accidental counter overflows
> > and underflows. This is important since overflows and underflows
> > can lead to use-after-free situation and be exploitable.
> >
> > The variable urdev.ref_count is used as pure reference counter.
> > Convert it to refcount_t and fix up the operations.
> >
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: David Windsor <dwindsor@gmail.com>
> > Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> 
> Added to s390/linux:features for the next merge window. Thanks.

Thank you very much!

Best Regards,
Elena.
> 
> --
> blue skies,
>    Martin.
> 
> "Reality continues to ruin my life." - Calvin.
