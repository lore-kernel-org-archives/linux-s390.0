From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: KVM: s390: Move two error code assignments in
 kvm_vm_ioctl_get_dirty_log()
Date: Tue, 24 Jan 2017 13:18:33 +0100
Message-ID: <64b94d75-6bad-1ebc-c35e-c036202bab01@redhat.com>
References: <70f41e59-d8a4-de42-6064-80ecf6acc065@users.sourceforge.net>
 <35411200-2bd6-1c65-7d7f-21a6353875ea@de.ibm.com>
 <01d581bb-9db6-cba1-e476-49c814c3ebf0@users.sourceforge.net>
 <50ae2ba4-572d-8524-fc31-acc1a8d1ad99@de.ibm.com>
 <75c6315c-8947-2816-64da-947f6a29ac57@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <75c6315c-8947-2816-64da-947f6a29ac57@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 24/01/2017 13:10, SF Markus Elfring wrote:
>>> Would you like to check run time consequences
>>> for the shown error code settings once more?
>>
>> Sure, lets for now ignore the fact that the performance of an error path
>> does not matter most of the time.
> 
> I am concerned that extra error code settings within the “success path”
> could influence the run time behaviour in unwanted ways.
> 
> 
>> After tree building and optimization your change should not matter at all
>> regarding performance for a decent compiler.
> 
> I find your optimism interesting.

Mummy says stupid is as stupid does.  Sorry, but I'm putting you on a
kill list.  It's just not possible to discuss things with you. You're
the first person _ever_ to get this treatment in about 20 years of me
using the Internet.

If other people want to merge your patches to KVM, they are free to do so.

Paolo
