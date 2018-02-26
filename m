Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 26 Feb 2018 12:16:28 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/17] Add kexec_file_load support to s390
In-Reply-To: <20180226012100.GA6019@linaro.org>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
        <20180214073543.GA12328@dhcp-128-65.nay.redhat.com>
        <20180214105449.1325bfbe@ThinkPad>
        <20180223083405.GA29498@dhcp-128-65.nay.redhat.com>
        <20180223110143.1747fb3f@ThinkPad>
        <20180224015956.GA11191@dhcp-128-65.nay.redhat.com>
        <20180226012100.GA6019@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180226121628.5e832adf@ThinkPad>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave
Hi AKASHI

On Mon, 26 Feb 2018 10:21:02 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> > 
> > Arch code need arch maintainer to review, maybe either of you can send
> > the common part first before the arch code, eg. AKASHI can split the common
> >  cleanup patches and post them as a separate series, after these prep
> > series are reviewed then other patches can be refreshed based on it.
> > 
> > Seems in AKASHI's series, only patch 2, 3 ,4 ,5 is needed if split out
> > as a common change series.  
> 
> Yeah, all of those are touching kernel/kexec_file.c and in turn
> they can conflict if being applied with 390 patches, but none of changes
> that I made on kexec_file.c are overlapped with Phillips', I suppose
> that merging these two patch sets is rather straightforward.
> 
> @Phillips: I hope that your patch#14 and #17 be aligned with my patch#3
> as it is factoring out arch_kexec_{image_probe, image_load, verify_sig}()
> and arch_kimage_file_post_load_cleanup().

Splitting the common code patches from the series is totally fine with me.

On Friday I managed to get my code working with AKASHI's patches. After setting
ARCH_HAS_PURGATORY and cleaning up the kexec_* functions it worked basically out
of the box. However there is one problem with older compilers on s390. Please
see my comment on patch #3 for details.

Thanks
Philipp
