Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgHRJN4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Aug 2020 05:13:56 -0400
Date: Tue, 18 Aug 2020 11:13:43 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [kvm-unit-tests RFC v2 3/4] run_tests/mkstandalone: add arch
 dependent function to `for_each_unittest`
Message-ID: <20200818091343.vp7eiyrrz34tyiy3@kamzik.brq.redhat.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com>
 <20200812092705.17774-4-mhartmay@linux.ibm.com>
 <20200813083000.e4bscohuhgl3jdv4@kamzik.brq.redhat.com>
 <87h7t51in7.fsf@linux.ibm.com>
 <20200814132957.szwmbw6w26fhkroo@kamzik.brq.redhat.com>
 <87ft8k497k.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ft8k497k.fsf@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Tue, Aug 18, 2020 at 11:03:27AM +0200, Marc Hartmayer wrote:
> On Fri, Aug 14, 2020 at 03:29 PM +0200, Andrew Jones <drjones@redhat.com> wrote:
> > On Fri, Aug 14, 2020 at 03:06:36PM +0200, Marc Hartmayer wrote:
> >> On Thu, Aug 13, 2020 at 10:30 AM +0200, Andrew Jones <drjones@redhat.com> wrote:
> >> > On Wed, Aug 12, 2020 at 11:27:04AM +0200, Marc Hartmayer wrote:
> >> >> This allows us, for example, to auto generate a new test case based on
> >> >> an existing test case.
> >> >> 
> >> >> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >> >> ---
> >> >>  run_tests.sh            |  2 +-
> >> >>  scripts/common.bash     | 13 +++++++++++++
> >> >>  scripts/mkstandalone.sh |  2 +-
> >> >>  3 files changed, 15 insertions(+), 2 deletions(-)
> >> >> 
> >> >> diff --git a/run_tests.sh b/run_tests.sh
> >> >> index 24aba9cc3a98..23658392c488 100755
> >> >> --- a/run_tests.sh
> >> >> +++ b/run_tests.sh
> >> >> @@ -160,7 +160,7 @@ trap "wait; exit 130" SIGINT
> >> >>     # preserve stdout so that process_test_output output can write TAP to it
> >> >>     exec 3>&1
> >> >>     test "$tap_output" == "yes" && exec > /dev/null
> >> >> -   for_each_unittest $config run_task
> >> >> +   for_each_unittest $config run_task arch_cmd
> >> >
> >> > Let's just require that arch cmd hook be specified by the "$arch_cmd"
> >> > variable. Then we don't need to pass it to for_each_unittest.
> >> 
> >> Where is it then specified?
> >
> > Just using it that way in the source is enough. We should probably call
> > it $ARCH_CMD to indicate that it's a special variable. Also, we could
> > return it from a $(arch_cmd) function, which is how $(migration_cmd) and
> > $(timeout_cmd) work.
> 
> My first approach was different…
> 
> First we source the (common) functions that could be overridden by
> architecture dependent code, and then source the architecture dependent
> code. But I’m not sure which approach is cleaner - if you prefer your
> proposed solution with the global variables I can change it.

I prefer my proposed solution. It's not necessary to provide and
source an arch-neutral function that will never do anything. And,
it will never do anything, because the function is supposed to be
arch-specific. If an arch doesn't implement the function, then
we don't need to call anything at all.

Thanks,
drew

> 
> Thanks for the feedback!
> 
> […snip]
> 
> -- 
> Kind regards / Beste Grüße
>    Marc Hartmayer
> 
> IBM Deutschland Research & Development GmbH
> Vorsitzender des Aufsichtsrats: Gregor Pillen 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen
> Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
