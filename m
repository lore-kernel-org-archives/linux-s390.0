Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgHNNaL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Aug 2020 09:30:11 -0400
Date: Fri, 14 Aug 2020 15:29:57 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [kvm-unit-tests RFC v2 3/4] run_tests/mkstandalone: add arch
 dependent function to `for_each_unittest`
Message-ID: <20200814132957.szwmbw6w26fhkroo@kamzik.brq.redhat.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com>
 <20200812092705.17774-4-mhartmay@linux.ibm.com>
 <20200813083000.e4bscohuhgl3jdv4@kamzik.brq.redhat.com>
 <87h7t51in7.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7t51in7.fsf@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Fri, Aug 14, 2020 at 03:06:36PM +0200, Marc Hartmayer wrote:
> On Thu, Aug 13, 2020 at 10:30 AM +0200, Andrew Jones <drjones@redhat.com> wrote:
> > On Wed, Aug 12, 2020 at 11:27:04AM +0200, Marc Hartmayer wrote:
> >> This allows us, for example, to auto generate a new test case based on
> >> an existing test case.
> >> 
> >> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >> ---
> >>  run_tests.sh            |  2 +-
> >>  scripts/common.bash     | 13 +++++++++++++
> >>  scripts/mkstandalone.sh |  2 +-
> >>  3 files changed, 15 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/run_tests.sh b/run_tests.sh
> >> index 24aba9cc3a98..23658392c488 100755
> >> --- a/run_tests.sh
> >> +++ b/run_tests.sh
> >> @@ -160,7 +160,7 @@ trap "wait; exit 130" SIGINT
> >>     # preserve stdout so that process_test_output output can write TAP to it
> >>     exec 3>&1
> >>     test "$tap_output" == "yes" && exec > /dev/null
> >> -   for_each_unittest $config run_task
> >> +   for_each_unittest $config run_task arch_cmd
> >
> > Let's just require that arch cmd hook be specified by the "$arch_cmd"
> > variable. Then we don't need to pass it to for_each_unittest.
> 
> Where is it then specified?

Just using it that way in the source is enough. We should probably call
it $ARCH_CMD to indicate that it's a special variable. Also, we could
return it from a $(arch_cmd) function, which is how $(migration_cmd) and
$(timeout_cmd) work.

> 
> >
> >>  ) | postprocess_suite_output
> >>  
> >>  # wait until all tasks finish
> >> diff --git a/scripts/common.bash b/scripts/common.bash
> >> index f9c15fd304bd..62931a40b79a 100644
> >> --- a/scripts/common.bash
> >> +++ b/scripts/common.bash
> >> @@ -1,8 +1,15 @@
> >> +function arch_cmd()
> >> +{
> >> +	# Dummy function, can be overwritten by architecture dependent
> >> +	# code
> >> +	return
> >> +}
> >
> > This dummy function appears unused and can be dropped.
> 
> So what is then used if the function is not defined by the architecture
> specific code?

Nothing, which works fine

 $ arch_cmd=
 $ $arch_cmd echo foo   # just do 'echo foo'

However, with what I wrote above, we now need a common arch_cmd function.
Something like

 arch_cmd()
 {
   [ "$ARCH_CMD" ] && return "$ARCH_CMD"
 }

Which would allow us to write

$(arch_cmd) $cmd ...

That does the same thing as above, but it now follows the pattern of
migration_cmd and timeout_cmd.

Thanks,
drew
