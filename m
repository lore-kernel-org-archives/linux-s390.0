Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7A1DC73C;
	Tue,  3 Sep 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393155; cv=none; b=A/lpw34G9Qprrj05XdSC5dBp73nYgkP8YUuVrjB6h/6NSUCIUpsmQhzIbj7DSm5/w9IFRRmP1F5dHeK/A0oidycCk0bP/+pvjrJa5xq2ax5m9evWwmDarh3FdAOfAVniKr5MY6U+0b+oQhadroiJilNaYM8emb1adCoPsiHSjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393155; c=relaxed/simple;
	bh=nIWxoEdxdpYS2LAAV4nl4juvkDo6Ne9RVUq0R/Uv+2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9EUvovzv3D88qy63sAG8uVBNpNMmXcysJxDKeGxIukpS4k7QFN0uYWzuIjImu2dLqM9o2MDl44jcWZOW2g+cb+XoBIVqdtVV6M29o6aLORTS5oQnQNIez0aWAhO5MkC1VoER5vJmPQmnAXuZNkBSBVjrBdb3EZ0OvwfFAaLGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=f/O7jRLe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="f/O7jRLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725393054; x=1725997854; i=deller@gmx.de;
	bh=uSMRWGhXiv8yW/HuN1qfAn2jc8joA1VHlXponTzNm2U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f/O7jRLeVpVHDTYNkuEz2uKV7A4+Crn3j5GUCM2YOV/WswDxrUN0gNg7rnunia6F
	 reM3xuZgG3z89wExuA+bSFw5wEKaH87I870h8eAosELgrOosUmhfS0+DW2x/tWlRs
	 r5VJcwYATkwKY7rBTB/AxJe96e81MB37j0WuobYCBpCHbjcOKxT514b0lKkf7tN9k
	 4bcGxgnClv/uLvngaYSVUknA83RThOybm58wqAsKdOjNlLZQiEdzzL1oWfggI7HOa
	 pvDFbklE+bRAasBqi04FcQVUZSXOM+PoyypSF83p01B3pkDRslqsIildO8CxVDY20
	 A6rbNO+VpIPP4KH6ow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTABT-1scwb30ouN-00IMx8; Tue, 03
 Sep 2024 21:50:54 +0200
Message-ID: <5dd4b6ab-62d3-4b6a-8de4-bdb1df7ebbe6@gmx.de>
Date: Tue, 3 Sep 2024 21:50:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: Make arch_get_unmapped_area() take vm_flags by
 default
To: Mark Brown <broonie@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Deepak Gupta <debug@rivosinc.com>, linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
 <20240902-mm-generic-shadow-stack-guard-v1-1-9acda38b3dd3@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20240902-mm-generic-shadow-stack-guard-v1-1-9acda38b3dd3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UosSD8lbAQ3xNgg4RaYC8o4mRKZmfEEhYZB4gXbYNOnflgwWEt6
 NgnuKo87mlBfO5/7GrkkFWKgK2gP16vuIc9vR37kK93c/Hyhxm1sI94ereqr0qEEGor37CT
 DIeKzfHO2lEofToGY0MUm+0fZ6RwhSinzQ2YlQ2q7PBcJtV99py1JOQU1i126fNx3i4f83X
 G5/kQZELEgxWwPIb3YD9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:olpIQZfQBpM=;72D3GxK5A8SdGYBNdykogNDkWMi
 wVtL1rhtrq+kleLns+9nbKh/ChrtKfX6DWbiGgBo+8ZnkuhTEfxXhbKNRRqdatNTkixI2hE63
 IhkrWf6kY7ejU8iGnRjnIQdbEM97Kt2R/jRVOak8TR/4c9nBxiKZK40u0zbwpmXYsvuWTYZqC
 k1us6UYBB6fMTjzJt8ZBJCPl/oQh61DY46xmqZT1NVDX77OMuXFFV5TNHv6xx7s5whbSLaxo6
 pbcj+/Nz4RwIk3xQJQNq1Q1EJH/+luSWPFUrLJuS9Zv6615zKNwYuBWsOIXwVkl9rkh2lBJLO
 tsL+NqnUIV3TZP01gapszn+qs9ko+0l8m1y+g0+PJ24A0Rd1ex1mQML7gtPuplBQ214kKd4Cb
 ANgwvoNckcmraEhlzSTnXf8e2RtfIXhqywO+17nig1YFSvdF+Tari9YinKCXaY1zZ/cjoqCjm
 A/fQKANWiAH5knZwnxIfJ6PZbusAWW4vRsHF9tXD/Jy27nldcUZ1MpYM+QfDRP0AZIGCE/Yap
 CIw0KFdpIICvAy+U0TfJpmPUW1hTrTfYOTVxLGZ2gGaPgc81+ArbOMhiSPonQDxGEQxpYXBkI
 5iKNRxJJRht70x9nddO53uOtyIgRK3YQlxLNDZq7viYMYUVmUNfUh9u1fm5jGKxKp3YboyK4q
 sJlriKovlKfy1dZ0GRWKooRwHc75udafyIPb4/vnYK6NGqPmY0VbfyvwVjYdaFPXlj8Enomw5
 0nthEUj87Oucc+1fabhNj4EhWvad108o7KdMCP4byp0VUjVjvn7dhCfQ4jwiRTB2ExBjqwfbR
 94T4jfrLaSsWVXNdu8qMZF5w==

On 9/2/24 21:08, Mark Brown wrote:
> When we introduced arch_get_unmapped_area_vmflags() in 961148704acd
> ("mm: introduce arch_get_unmapped_area_vmflags()") we did so as part of
> properly supporting guard pages for shadow stacks on x86_64, which uses
> a custom arch_get_unmapped_area(). Equivalent features are also present
> on both arm64 and RISC-V, both of which use the generic implementation
> of arch_get_unmapped_area() and will require equivalent modification
> there. Rather than continue to deal with having two versions of the
> functions let's bite the bullet and have all implementations of
> arch_get_unmapped_area() take vm_flags as a parameter.
>
> The new parameter is currently ignored by all implementations other than
> x86. The only caller that doesn't have a vm_flags available is
> mm_get_unmapped_area(), as for the x86 implementation and the wrapper us=
ed
> on other architectures this is modified to supply no flags.
>
> No functional changes.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   arch/alpha/kernel/osf_sys.c       |  2 +-
>   arch/arc/mm/mmap.c                |  3 ++-
>   arch/arm/mm/mmap.c                |  7 ++++---
>   arch/csky/abiv1/mmap.c            |  3 ++-
>   arch/loongarch/mm/mmap.c          |  5 +++--
>   arch/mips/mm/mmap.c               |  2 +-
>   arch/parisc/kernel/sys_parisc.c   |  5 +++--
>   arch/parisc/mm/hugetlbpage.c      |  2 +-

Acked-by: Helge Deller <deller@gmx.de>  # parisc

Helge
