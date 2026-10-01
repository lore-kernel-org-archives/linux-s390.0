Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3E28CF4A
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876385; cv=none; b=HS+TbGj5LAlaK1w/f7x6Nl/epsPpSWAYBfO0CgGe0Aogfl397C54LPgOwZT0EUoIyyyhjrbNe0/wzL+o+qHXCOYXZFVsmbk1Urse0Sx02lnACJUQy5jin2BqkIgIwExTW/EBxD4CnpArxNdydXMuKMIwtfv+kjLaaWK2pEJf7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876385; c=relaxed/simple;
	bh=dK1YC8FLSUXxmYfSB8ouUVvYnUfdNVfIde9XouOn+8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVLIYRfV3+P2EVRtyzg7qGZFLH9txN7Ov/SFZd6cqSe+30Y1VjlThcGQvy/DR/5dbN+SMaje752slMS9sefQ/dBVTS0i2xsu7K2t4G2P3jJlioTSAS0wZC6ZQukZ5fMt2v0502n4giJGIiQPj+bFdL5lFe5cBi6seEoGGz5FRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=kdqSq7ON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tFtwlagK; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="kdqSq7ON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tFtwlagK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 953BC13803E1
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 13:39:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 01 Oct 2026 13:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790876381;
	 x=1790883581; bh=l3aq13J5VX9YHBy+nDgiTWl41JHuJfuq9o7FqdgtotQ=; b=
	kdqSq7ONSi0lCoc73xVfCf0+TFUtGLQ7rPztnEBFgqNS25kl0UE2ydYW6SAq4qPz
	EWwWi6Jw3w67qM11Pa6ILzqkKawDmHle7CyFrKqeweES/L5JDCCwVhoMIoa5Bl+B
	oNBA1N5QyFADEWk155aFKZ36Id6Fd1jvO5V1LWzvxw/aHqgOva1pi5Fimta6GDxK
	LY+4xoehiYHkLPXhjjjGVnmdBFYJVPqINy0sIbjR5c4jtmMmW1YKE8d5TKF032zk
	qUZz+OIzpEI76WdwsE3sPpQ/XNIOpG8SJkrWibuxaUMweE/76B17Wr3PFHTqsLSO
	QO+AJHyDpFCZYfEtR04sUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790876381; x=
	1790883581; bh=l3aq13J5VX9YHBy+nDgiTWl41JHuJfuq9o7FqdgtotQ=; b=t
	FtwlagKkqMq92EXRtCIhXFmPZqwc04B6V7Xrod3Y3SE25ilvAQNcvJnHjZSVy7HR
	5jdBUNSA3RPIe9XvW/RWSEOxDs1yeROoWR06orhQzf5XQQbZkvFoVfEx4M6jgChW
	BoDlQSfm9w+b/dhDhe/0ikdEIFaUjz1eMao8lio1sPifIu7AfFTiBQ98oDhQ6o/r
	n4WLrTOF66O+S5JvVkosjThNjh9kXiVnSXH4CZgen49piBSrHmI09weFPAavVWQq
	APRPkEx3KV5DQFdpif/qhaMTdZeXIj016XBuQEu5mhLa7zfMxZbJhvTznqrJOJi6
	SDM/8jixveElLhdfeOmjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790876381; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:4GAG+487ypxepS3EmQMo54XJ8zCIarkh0ubZaTSZI86PcUU
	PLLbxrDu1IfQYxPe35bL1gnVHErtbUUAnI7FWDFHrhQqh/opDHqoRgkO3kqdPYBW
	fg87FPd+5bwO5Bo598F/tXLuXF4Z8V7CeSLj1iyU2GpkRra497UznzaK3sgEPMkH
	QqM9cRjxZuAxzUMf5HCX1w581kVJqJT6ztipL0nvsq2sScBPc87ood0gttd+hvjG
	RunFBCEbUiLqxQxpcB2lQrqDKGn6PY/haTsEyD7BRUlmUEWE71Nr9TKkcesUlw6r
	Skeh9v35DZ5STEwaTQNJIPGLV/35j0Gz0Nx/3SQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:z2qhpcc+RzePh3dNm2m2+Knepu4wJdsPJN+T/6bVKtY=:dK1YC8FLSUXxmYfSB8ouUVvYnUfdNVfIde9XouOn+8A=;
X-ME-Sender: <xms:3Jq-aug3K9pvUYA2R758yEKTaUF6hWItBV3oCBoeYgaGqw1bL-jpUQ>
    <xme:3Jq-apsyY0eOS2RVEV4MxabJNPqhgVpf8RdKuodXZmIQpYnubLPRtFp_7WU6Q7jDA
    85yFi2mkP5fQE7m2tp8OGgZXHzivu4iS2RZ0pTQmX0dxM1rHMybG78>
X-ME-Received: <xmr:3Jq-aqFQYje6EM_ix9p9ipNVzRSwHOuJoq9wYvG8RU6-RecYNr_7OTpC7JoXDQ>
X-ME-Proxy-Cause: dmFkZTFjMvnoc2ZRA7bRZ4ZKMJykf9Z98u/a2S5rh6yqc8FD4Z2e29OmoZxkc+onHeIyrO
    dAAb7ujMFpuUmFa0XOLFnfycqmpnr+UIiD5zRwb5uYR2lYv6+v5NCR1bPSqjMBLj2CqaW6
    bGfvCIuo5XeKSJoFMuhojzwmrcvpaYASjzwRKcIYro0OeFDAHuRae9leb0cb4m7sBGrsmE
    jCoOsgcuxYpxueCYXFZedkdKyG59g/H4j/0JzaspL9zC72ImcaIHxOZgPV3I9KXiTG0cHv
    OKxlOLPWD6+O1841nvrr30eav+R/UAz5An5jQuTZz2zK0mCKezUT+eizpE40cUJR7nRiOC
    XWlYJHtlaMCbCnJt1eiwOL4U34V7yoz/m0dHBpDTvXhSeHaRsWqKRS+kbBH7Idg8tmSPPg
    3dC7joSgHbDzjQWILZ9lklcXyfU32/naPYE5wnfMlCD6FbjI4Mw6i/84fzJLpUrDG2+n5e
    A/yg01EdAeC08uEihbbzzhS+G/gMlcNShtLuelgSPD1UUbEVM1ikYZyALm7R+52Qvea4eL
    tlhfdWJrehWohKCYe9EBF44U576JhWbZNUtrD5Ggu8lWSECAs78EGda4MH2XPU9206tRxT
    BfXUkX3ZM1nndndcQ1wpG/cZBIpmYWliTlcl/KvwvpB30FB4sRJgKyA08t4A
X-ME-Proxy: <xmx:3Jq-an9GVRhMCzGmC4bOWS5lTld-0cmumjXLMoKNPTMmoxFG1RUUXQ>
    <xmx:3Jq-aqiD2bw0KgH2UsuNdkpllbd7MfAGcm9wXb9r8B-s4A--SrmXJQ>
    <xmx:3Jq-at-UU8G7ITOaH0LYOQiiMrAXOfOqx3qLXxj0kx7u8JijGh2PuA>
    <xmx:3Jq-amSI7B9o8dIyEjb4yz6gOOlTA-ra5DuJiK0vOTucwDmnY0FH9A>
    <xmx:3Zq-am7_0KFlHTcvcD3rwRRRNNJcF2umGR6KZWtPiqExSxvFHyXd_6xQ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:39:38 -0400 (EDT)
Date: Thu, 1 Oct 2026 11:39:36 -0600
From: Alex Williamson <alex@shazbot.org>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, alex@shazbot.org
Subject: Re: [PATCH v4 4/6] KVM/vfio: Use file-based reference counting for
 KVM
Message-ID: <20261001113936.21bc850a@shazbot.org>
In-Reply-To: <20260928-vfio-v4-4-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
	<20260928-vfio-v4-4-e32e226d5932@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 15:07:05 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 423ead48aafe..ed96acfa8635 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -472,36 +472,14 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>  EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
>  
>  #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm)
>  {
> -	void (*pfn)(struct kvm *kvm);
> -	bool (*fn)(struct kvm *kvm);
> -	bool ret;
> -
>  	lockdep_assert_held(&device->dev_set->lock);
>  
>  	if (!kvm)
>  		return;
>  
> -	pfn = symbol_get(kvm_put_kvm);
> -	if (WARN_ON(!pfn))
> -		return;
> -
> -	fn = symbol_get(kvm_get_kvm_safe);
> -	if (WARN_ON(!fn)) {
> -		symbol_put(kvm_put_kvm);
> -		return;
> -	}
> -
> -	ret = fn(kvm);
> -	symbol_put(kvm_get_kvm_safe);
> -	if (!ret) {
> -		symbol_put(kvm_put_kvm);
> -		return;
> -	}
> -
> -	device->put_kvm = pfn;
> -	device->kvm = kvm;
> +	device->kvm = get_file(kvm);
>  }

Nit, retaining the "_safe" naming here and through the callers is now
meaningless and could be dropped.  Otherwise,

Acked-by: Alex Williamson <alex@shazbot.org>

Thanks,
Alex
