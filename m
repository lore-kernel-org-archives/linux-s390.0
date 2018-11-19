From: Michael Mueller <mimu@linux.ibm.com>
Date: Mon, 19 Nov 2018 17:37:47 +0000
Subject: Re: [PATCH 04/10] KVM: s390: add metric vcpus_in_sie to struct kvm_arch
Message-Id: <1c4c0b42-1a10-58e6-97b1-564f16b44615@linux.ibm.com>
In-Reply-To: <3ad892e2-29bc-6f85-9db5-385be4f4049d@linux.ibm.com>
References: <3ad892e2-29bc-6f85-9db5-385be4f4049d@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 08.11.18 02:05, Halil Pasic wrote:
>
> On 11/07/2018 10:52 PM, Pierre Morel wrote:
>>>>>> Mimu,�we�just�spoke�about�--�thus�a�reminder�for�us,�and�a�FYI�for
>>>>>> the�rest.�vcpus_in_sie�!=�0�does�not�necessarily�mean�that�FW�can
>>>>>> deliver�GISA�interrupts�to�the�guest�(and�thus�we�don't�have�to
>>>>>> dispatch�a�suitable�vcpu):�if�all�cpus�in�SIE�mask�IO�interrupts�it
>>>>>> does�not�really�matter�that�they�are�in�SIE.�I.e.�we�should�still�get
>>>>>> alerted�and�try�to�dispatch�an�eligible�vcpu.
>>>> If�I�understood�well,�I�do�not�agree.
>>> I�don't�think�you�understood�well.
>>>
>>>> If�all�the�vCPU�have�ISC�masked�in�CR6�we�do�not�need�to�dispatch�the�vCPU,�running�or�not.
>>>> If�running,
>>>> The�first�vCPU�that�will�load�CR6�with�at�least�one�bit�of�the�ISC�being�one�will�be�scheduled�by�the�firmware.
>>>>
>>> Let�me�help�you�with�an�example.�Our�guest�has�3�vCPUs.�One�(CPU1)�of�those�is�doing�something
>>> very�important�real-time-ish�stuff�and�is�currently�in�SIE�with�all�maskable�interrupts
>>> shut�off�(the�stuff�is�very�important).�The�other�two�vCPUs�(CPU2�and�CPU3)�are�open�for�IO
>>> interrupts�but�idle,�that�is�not�in�SIE.
>>>
>>> AFAIU�we�should�opt�for�getting�alerted�and�kicking�CPU2�or�CPU3�in�this�case,�as�we�can
>>> not�assume�that�CPU1�will�open�up�for�interrupts�any�time�soon.�I�read�your�text�like,
>>> you�think�we�can�make�that�assumption.�Did�I�misunderstand�you?�If�not,�why�do�you�think
>>> we�can�make�that�assumption?
>> OK, I undertand, you want to make an optimization and kick one idle CPU not�having�the�interrupt�masked.
>> Seems�right�for�me,�but�I�think�we�could�implement�this�later.
> I'm not sure if it is just an optimization or not. If we don't have another mechanism that
> will kick one of the two form the example, the guest will loose initiative. And that is a bug
> because it could wait for the IRQ forever. If we do have a different mechanism that we are going to
> keep on relying, then everything we do around GIB is just an optimization in the same sense
> as the point under discussion. I have not looked enough at the proposed code to tell if guest
> looses initiative or not.
>
> Important thing is we are roughly on the same page I think.
>
> Regards,
> Halil
I have looked into this scenario described by you and spend some time 
dealing with it. But before I will
add any potential unused code I'm asking you to provide a piece of code 
producing this scenario. Up to
then we shall go with the option provided in patch series v2.

Michael
