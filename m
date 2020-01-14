Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60047 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANRvM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jan 2020 12:51:12 -0500
Date: Tue, 14 Jan 2020 18:51:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 3/4] s390x: smp: Test all CRs on initial
 reset
Message-ID: <20200114185101.1f2481c8.cohuck@redhat.com>
In-Reply-To: <bec10775-3713-4604-1b49-27d49682db43@redhat.com>
References: <20200114153054.77082-1-frankja@linux.ibm.com>
        <20200114153054.77082-4-frankja@linux.ibm.com>
        <bec10775-3713-4604-1b49-27d49682db43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Tue, 14 Jan 2020 18:01:32 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 14/01/2020 16.30, Janosch Frank wrote:
> > All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
> > so we also need to test 1-13 and 15 for 0.
> > 
> > And while we're at it, let's also set some values to cr 1, 7 and 13, so
> > we can actually be sure that they will be zeroed.
> > 
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > ---
> >  s390x/smp.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)

> > @@ -219,6 +237,7 @@ static void test_reset(void)
> >  
> >  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
> >  	report(smp_cpu_stopped(1), "cpu stopped");
> > +	smp_cpu_destroy(1);  
> 
> Shouldn't that rather be part of patch 2/4 ? I'd maybe also move this to
> the main() function instead since you've setup the cpu there...? Also is
> it still ok to use smp_cpu_start() in test_reset_initial() after you've
> destroyed the CPU here in test_reset()?

Isn't it simply wrong? I thought the pattern was supposed to be

- setup cpu
- do some tests, including stopping/restarting/etc.
- destroy cpu [currently missing]

> 
> >  	report_prefix_pop();
> >  }  
> 
>  Thomas
