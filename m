From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/5] s390: Guest support for virtio-ccw.
Date: Tue, 30 Oct 2012 14:43:29 +0100
Message-ID: <508FD981.4010200@suse.de>
References: <1351516046-30037-1-git-send-email-cornelia.huck@de.ibm.com> <CE383E4A-4C23-4E8C-B237-EFD2F849D884@suse.de> <20121029191504.0d36a68a@BR9GNB5Z> <88DEC3C5-44B9-498D-9F7F-A0AFAB527235@suse.de> <20121030140452.32dfa251@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20121030140452.32dfa251@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 10/30/2012 02:04 PM, Cornelia Huck wrote:
> On Mon, 29 Oct 2012 19:33:14 +0100
> Alexander Graf<agraf@suse.de>  wrote:
>
>> On 29.10.2012, at 19:15, Cornelia Huck wrote:
>>
>>> On Mon, 29 Oct 2012 18:55:21 +0100
>>> Alexander Graf<agraf@suse.de>  wrote:
>>>
>>>> On 29.10.2012, at 14:07, Cornelia Huck wrote:
>>>>
>>>>> Avi, Marcelo,
>>>>>
>>>>> I'd like to propose inclusion of the guest support patches for
>>>>> virtio-ccw into 3.8.
>>>>>
>>>>> I'm confident that the host<->  guest interface for virtio-ccw
>>>>> is fine now, and the patches have been extensively tested by our
>>>>> internal test team.
>>>>>
>>>>> Patch 1 might conceivably be 3.7 material, though I fear it's a
>>>>> bit late for that.
>>>> Well, patch 1 without virtio-ccw support is quite useless, right? You wouldn't get any I/O at all.
>>> Yes, but it stops in an obvious way (no devices can be found) and
>>> not with a strange backchain.
>> Hrm. Then it's probably best to actually CC stable as well :)
> If there aren't any objections, I'll just respin with minor changes and
> put in a cc:stable.

Awesome. No objections from me.


Alex
