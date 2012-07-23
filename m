From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC V5 0/3] kvm: Improving directed yield in PLE handler
Date: Mon, 23 Jul 2012 09:35:38 +0200
Message-ID: <500CFECA.1050708@de.ibm.com>
References: <20120718133717.5321.71347.sendpatchset@codeblue.in.ibm.com> <20120720173640.GA22659@amt.cnet> <500BF35D.6050605@linux.vnet.ibm.com> <500BF585.2080109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <500BF585.2080109@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Srikar <srikar@linux.vnet.ibm.com>, S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

On 22/07/12 14:43, Avi Kivity wrote:
> On 07/22/2012 03:34 PM, Raghavendra K T wrote:
>>
>> Thanks Marcelo for the review. Avi, Rik, Christian, please let me know
>> if this series looks good now.
>>
> 
> It looks fine to me.  Christian, is this okay for s390?
> 
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com> # on s390x
