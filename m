From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] KVM: s390: fix build failure
Date: Wed, 8 Jun 2016 18:09:17 +1000
Message-ID: <20160608180917.4d6d3434@canb.auug.org.au>
References: <1465336170-23064-1-git-send-email-sudipm.mukherjee@gmail.com>
	<5757AA6F.705@de.ibm.com>
	<20160608053129.GA3311@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608053129.GA3311@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko,

On Wed, 8 Jun 2016 07:31:29 +0200 Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> On Wed, Jun 08, 2016 at 07:17:35AM +0200, Christian Borntraeger wrote:
> > On 06/07/2016 11:49 PM, Sudip Mukherjee wrote:  
> > > etr_ptff definitions are moved and renamed but we missed updating them
> > > here and as a result s390 defconfig and allmodconfig was failing with
> > > the error:
> > > arch/s390/kvm/kvm-s390.c:230:45: error: 'ETR_PTFF_QAF' undeclared
> > > 
> > > Fixes: cc8f94656487 ("s390/time: move PTFF definitions")
> > > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>  
> > 
> > Thank you for the report and patch.
> > 
> > This is linux-next only. Its a conflict between my kvms390 queue and 
> > Martins s390 queue. We cannot apply this directly as it would break
> > the build of my tree when not merged in next. (and it does not apply
> > on Martins tree).
> > 
> > I will have a look how to fix that up.  
> 
> We could ask Stephen Rothwell to apply the patch only to linux-next? ;)

Martin sent me the same patch earlier and I applied it to the merge of
the kvms390 tree today.  Someone needs to remember to tell Linus when
the time comes.

-- 
Cheers,
Stephen Rothwell
