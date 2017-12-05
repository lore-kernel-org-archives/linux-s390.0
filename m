From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 4/4] KVM: s390: Fix skey emulation permission check
Date: Tue, 5 Dec 2017 19:19:27 +0100
Message-ID: <b90ad75a-669a-2d3a-b7f3-c8332488c1c9@de.ibm.com>
References: <20171205083321.102933-1-borntraeger@de.ibm.com>
 <20171205083321.102933-5-borntraeger@de.ibm.com>
 <545edf77-fca3-3948-0ccd-04a3cb19093b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <545edf77-fca3-3948-0ccd-04a3cb19093b@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 12/05/2017 05:53 PM, David Hildenbrand wrote:
> On 05.12.2017 09:33, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.vnet.ibm.com>
>>
>> All skey functions call skey_check_enable at their start, which checks
>> if we are in the PSTATE and injects a privileged operation exception
>> if we are.
> 
> Correct thing to do, are we sure we even get an intercept?
> (no documentation at hand :( )


If we run keyless we certainly get intercepts. The good thing is that
Linux hosts do not use the keys and run with PSW key 0, so this does not
open any protection issue for those. 
If we run with keys enabled, we might also get exits if the host holds
the pgste lock for too long.
