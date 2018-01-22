From: Eugene Syromiatnikov <esyr@redhat.com>
Date: Mon, 22 Jan 2018 12:48:57 +0000
Subject: Re: [strace PATCH 00/12] s390 architecture support improvements
Message-Id: <20180122124857.GC18640@asgard.redhat.com>
In-Reply-To: <20180120112323.GA6287@osiris>
References: <20180120112323.GA6287@osiris>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Jan 20, 2018 at 12:23:23PM +0100, Heiko Carstens wrote:
> On Thu, Jan 18, 2018 at 07:16:31AM +0100, Eugene Syromyatnikov wrote:
> > Hello.
> > 
> > This patch set introduces compat personality support on s390x along with
> > decoders of s390-specific system calls.
> > 
> > Unfortunately, I am no s390 expert by any means, so I likely have missed
> > something.  I also have little idea regarding applications where these
> > s390-specific system calls are used, so the feedback regarding quality
> > of the decoders is also welcome.
> 
> Looks all good to me. However the s390_sthyi test case fails:
> 
> -s390_sthyi(STHYI_FC_CP_IFL_CAP, {/* header */ {infhflg1=00, ...}, /* machine */ {infmval1=0xf0, infmscps=2, infmdcps=0, infmsifl=90, infmdifl=2, ...}, /* partition */ {infpflg1=0x80, infpval1=0xfc, infppnum=63, infpscps=0, infpdcps=0, infpsifl=32, infpdifl=0, infppnam="\xe2\xf8\xf3\xd3\xd7\xf6\xf0\x40" /* "S83LP60 " */, ...}, /* hypervisor 1 */ {infyflg1=0xc0, infycpt=1, infyiflt=2, infysyid="\xc2\xd6\xc5\xe2\xf8\xf3\xf6\xf0" /* "BOES8360" */, infysifl=32, ...}, /* guest 1 */ {infgflg1=0x4, infgusid="\xe2\xf8\xf3\xf6\xf0\xf0\xf1\xf6" /* "S8360016" */, infgsifl=6, infgpflg=00, ...}}, [0], 0) = 0
> +s390_sthyi(STHYI_FC_CP_IFL_CAP, {/* header */ {infhflg1=00, ...}, /* machine */ {infmval1=0xf0, infmscps=2, infmdcps=0, infmsifl=90, infmdifl=2, ...}, /* partition */ {infpflg1=0x80, infpval1=0xfc, infppnum=63, infpscps=0, infpdcps=0, infpsifl=32, infpdifl=0, infppnam="\xe2\xf8\xf3\xd3\xd7\xf6\xf0\x40" /* "S83LP60 " */, ...}, /* hypervisor 1 */ {infyflg1=0xc0, infysyid="\xc2\xd6\xc5\xe2\xf8\xf3\xf6\xf0" /* "BOES8360" */, infysifl=32, ...}, /* guest 1 */ {infgflg1=0x4, infgusid="\xe2\xf8\xf3\xf6\xf0\xf0\xf1\xf6" /* "S8360016" */, infgsifl=6, infgpflg=00, ...}}, [0], 0) = 0
>  +++ exited with 0 +++
> s390_sthyi.gen.test: failed test: ../../strace -e trace=s390_sthyi -a47 ../s390_sthyi output mismatch

Thank you for the report!  Unfortunately, when I decided that
infycpt/infyiflt aren't that important for abbreviated output, I forgot
to update the test, and the lack of MT-enabled hardware didn't allow me
to catch it early.  I'll resend the patch with the fixed test.
