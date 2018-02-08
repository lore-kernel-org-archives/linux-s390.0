From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] KVM: s390: use switch vs jump table in priv.c
Date: Thu, 8 Feb 2018 09:01:47 +0100
Message-ID: <20180208080147.GB3937@osiris>
References: <20180206112127.19014-1-borntraeger@de.ibm.com>
 <20180206112127.19014-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180206112127.19014-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 06, 2018 at 11:21:26AM +0000, Christian Borntraeger wrote:
> instead of having huge jump tables for function selection,
> lets use normal switch/case statements for the instruction
> handlers in priv.c
> 
> bloat-o-meter shows that the saving are even bigger than
> just the removed jump tables.

Which is not true since bloat-o-meter does not take the rodata section into
account, which grows by 1720 bytes with this commit.

> add/remove: 0/11 grow/shrink: 8/0 up/down: 1934/-10246 (-8312)
> Function                                     old     new   delta
> kvm_s390_handle_b2                            42     958    +916
> handle_iske                                  178     558    +380
> handle_rrbe                                  178     546    +368
> kvm_s390_handle_b9                            42     222    +180
> kvm_s390_handle_01                            42      74     +32
> kvm_s390_handle_eb                            42      70     +28
> handle_sckpf                                 176     204     +28
> handle_lctlg                                 628     630      +2
> handle_ptff                                   36       -     -36
> handle_sckpf.part                             78       -     -78
> handle_epsw                                  154       -    -154
> handle_stfl                                  316       -    -316
> handle_rrbe.part                             470       -    -470
> handle_iske.part                             482       -    -482
> handle_io_inst                               518       -    -518
> x01_handlers                                2048       -   -2048
> eb_handlers                                 2048       -   -2048
> b9_handlers                                 2048       -   -2048
> b2_handlers                                 2048       -   -2048
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
