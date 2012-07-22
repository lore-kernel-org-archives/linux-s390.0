From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V5 0/3] kvm: Improving directed yield in PLE handler
Date: Sun, 22 Jul 2012 15:43:49 +0300
Message-ID: <500BF585.2080109@redhat.com>
References: <20120718133717.5321.71347.sendpatchset@codeblue.in.ibm.com> <20120720173640.GA22659@amt.cnet> <500BF35D.6050605@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <500BF35D.6050605@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Srikar <srikar@linux.vnet.ibm.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/22/2012 03:34 PM, Raghavendra K T wrote:
> 
> Thanks Marcelo for the review. Avi, Rik, Christian, please let me know
> if this series looks good now.
> 

It looks fine to me.  Christian, is this okay for s390?

-- 
error compiling committee.c: too many arguments to function
