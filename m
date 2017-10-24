Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH 0/3] s390 refcount conversions
Date: Tue, 24 Oct 2017 06:58:09 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B802B4A7E@IRSMSX102.ger.corp.intel.com>
References: <1508485670-24070-1-git-send-email-elena.reshetova@intel.com>
 <bd915b0f-4c13-ae9c-00f9-9420102f4412@linux.vnet.ibm.com>
In-Reply-To: <bd915b0f-4c13-ae9c-00f9-9420102f4412@linux.vnet.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julian Wiedmann <jwi@linux.vnet.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "ubraun@linux.vnet.ibm.com" <ubraun@linux.vnet.ibm.com>, "peterz@infradead.org" <peterz@infradead.org>, "keescook@chromium.org" <keescook@chromium.org>
List-ID: <linux-s390.vger.kernel.org>

> On 10/20/2017 09:47 AM, Elena Reshetova wrote:
> > This series, for S390, replaces atomic_t reference
> > counters with the new refcount_t type and API (see include/linux/refcount.h).
> > By doing this we prevent intentional or accidental
> > underflows or overflows that can led to use-after-free vulnerabilities.
> >
> > The patches are fully independent and can be cherry-picked separately.
> > Patches are based on top of linux-next as of yesterday.
> > If there are no objections to the patches, please merge them via respective trees
> >
> > Elena Reshetova (3):
> >   [S390] vmur: convert urdev.ref_count from atomic_t to refcount_t
> >   [S390] net: convert lcs_reply.refcnt from atomic_t to refcount_t
> >   [S390] qeth: convert qeth_reply.refcnt from atomic_t to refcount_t
> >
> >  drivers/s390/char/vmur.c          |  8 ++++----
> >  drivers/s390/char/vmur.h          |  4 +++-
> >  drivers/s390/net/lcs.c            | 10 +++++-----
> >  drivers/s390/net/lcs.h            |  3 ++-
> >  drivers/s390/net/qeth_core.h      |  3 ++-
> >  drivers/s390/net/qeth_core_main.c | 10 +++++-----
> >  6 files changed, 21 insertions(+), 17 deletions(-)
> >
> Thanks Elena, I picked up the two network patches. Also removed the WARN_ONs
> while applying,
> those who care may use CONFIG_REFCOUNT_FULL.

Thank you Julian! I had them first removed also, but since we got x86 that doesn't 
WARN in these cases, I put them back just to make sure I don't make any
unexpected changes.  

Do you know who would be the correct person to take the last patch? 

Best Regards,
Elena
