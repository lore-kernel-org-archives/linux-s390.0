Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7333DEFE;
	Fri, 27 Mar 2026 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580166; cv=none; b=PYppQGzQakaZvb5XWfx246yOneNOlAL8md37/l9d94+CyEK9+5RjMJgLO2TG/kMscSEuwHwpTrNXJDG4BbxN7ozcPVDHphHm24/SUQch9gisKh+j1DyKDV2Sq/t6faGQEsnbPlaX+xQhNP0aa171i0MMjMV26WScxxI0aSdMfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580166; c=relaxed/simple;
	bh=OXABB1eFjeN1oGH/SXFHZZT4FCIkSR1xm49zyhunO7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mL6oPjZ6AV+g3fkAf9SZCzXneiKUUjWFVQz58U87NpDv7XBvPVHCKNOHPf/08i0XS8inf7tWC62+cJqUlB1RdL47O/nyrRqYb9pjCpWJ6kPVMguhXeqYD5nmaDsRpqDGV8+ooT/tcUHcSQbhPwczO7hsMW1ClEOCeLMuInIHzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62989C116C6;
	Fri, 27 Mar 2026 02:55:59 +0000 (UTC)
Message-ID: <b89ac970-7990-4a12-9769-82efc945c950@linux-m68k.org>
Date: Fri, 27 Mar 2026 12:55:55 +1000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application of
 align
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
 <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/3/26 02:56, Ilpo Järvinen wrote:
> Aligning res->start by align inside pcibios_align_resource() is
> unnecessary because caller of pcibios_align_resource() is
> __find_resource_space() that aligns res->start with align before
> calling pcibios_align_resource().
> 
> Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
> result in changing start either because 0x300 bits would have not
> survived the earlier alignment if align was large enough to have an
> impact.
> 
> Thus, remove the duplicated aligning from pcibios_align_resource().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

LGTM.

Acked-by: Greg Ungerer <gerg@linux-m68k.org>


> ---
>   arch/m68k/kernel/pcibios.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 1415f6e4e5ce..7e286ee1976b 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>   	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>   		start = (start + 0x3ff) & ~0x3ff;
>   
> -	start = (start + align - 1) & ~(align - 1);
> -
>   	return start;
>   }
>   

