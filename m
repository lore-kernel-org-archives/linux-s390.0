Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496245;
	b=eGJQ6jMhAE6Tsr4ZctIJEtJguLSsktdCuWW8JM3NzMkjRGm+a2bwx3Q/Yw3x6Uw6BaKh
	 EuaEFDQb415ryCm5OPAXudvcHrKx87HabPRFMpQIXMtw+5jAa6ref0QnNzV3cnrOBPmWl
	 KqleCY1Covv06JgI+jdBP4lRb++IKFly8nHCFI8tuMfagektNaFocP4LUOWqfu+poiNSj
	 iCgzqQRgiQvFXnypGpKaPpS7yLRW9Oc95LpGH5IIUuMijP69QxfIQaZpk17m+0D6TnKFa
	 MGpA2sdUTAzD+7QvliWGjruobeKnN0PLpf9wqXCcqpWwdybQnltJKIosG4iUE105YsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496245;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=acMkc7QyDnTSn7Mns6ex97JJ3VU7HnocG3Qg7L3QWME=;
	b=uDr2+dCiElOs2Vdwy0TvRrhs/FRgSgI9H0B2CR0fWy+oqI4DWmUYTEMDhpYh44ve2CkV
	 QN1uxTsChHYUt6hrwbCsGnxlt/UV+ETsGdRBXnJVZCKz5SeAzeQFy4UzZna/ZVUzjh+Rm
	 8d7Pu3oyCzVSTCvT18XYWIBdUAIDEHjkOa6INbjJ9tBn2Gyb44smDMMWY8kRjxENtMDIA
	 3ksFVsw3qUDarFp/TogEA2JTk5znrzrszRHfbeVzgthVYzKysiZK1HTB7R7TVLZjCeMX5
	 X5CRg9OshQS+E3hvaLnOvEEBkHxDxPy0DcgzHotxzQX4vNp9B3AIsX2XOei1Eh8qX4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AMVHXeZl;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB2606A31C;
	Thu, 12 Nov 2026 15:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63EB2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AMVHXeZl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=acMkc7QyDnTSn7Mns6ex97JJ3VU7HnocG3Qg7L3QWME=; t=1794496243; x=2109856243; 
	b=AMVHXeZlqO9tBKaHc4Hx08Gkj1QvsB9bugnWR2CrvNlavhxc1rjwJsirQ4Fa2DFMr9IiMI9yUkp
	93EtZFr2XzlGFXMQLLhmgsYWA3JMzbxFa19CSegfV05sLeZW4CLTY0ojl8kZvU2wnArSOF6jSgJQY
	R7SWRYyCyF18n3xLjhAdnvxpegZqDviwk5XEhW+BxG61r8PsBHEGLccs1CGlrs39MWJbC6mhrAgcA
	OuPOz/mfXtSkmyTvBJ52ON2cEYa14uT4/A9zAZEoBXNBZpncEyJPUPrJoM8iLJOwgMG+Iqf+jpc9f
	mitQJG1u7xpHOrXTbcj6IkalbDcSCyn+SS3g==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xRWRi-009bCN-Iw; Thu, 12 Nov 2026 16:10:38 +0100
Message-ID: <ecabf256-3dff-47dc-9e59-8f381c2df4ff@igalia.com>
Date: Thu, 12 Nov 2026 12:10:45 -0300
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/15] syscalls: Add an option for offsetting the
 common table
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-9-8d1275885d9c@igalia.com>
 <0cfb4dbf-f3e2-4ceb-ab89-0453ae59793d@app.fastmail.com>
 <e3910a18-dc28-470f-be2f-6a6d568ba7e3@igalia.com>
 <301115f6-3f1e-4e83-bc01-0ba49dec496a@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <301115f6-3f1e-4e83-bc01-0ba49dec496a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Em 12/11/2026 12:08, Arnd Bergmann escreveu:
> On Thu, Nov 12, 2026, at 15:37, André Almeida wrote:
>> Em 12/11/2026 11:07, Arnd Bergmann escreveu:
>>> On Thu, Nov 5, 2026, at 21:05, André Almeida wrote:
>> So one option does a string concat, the other option really does a sum
>> operation. If I had used --offset 110, the result would be
>>
>> #define __NR_file_setattr (110 + 469)
>> #define __NR_listns (110 + 470)
>> #define __NR_rseq_slice_yield (110 + 471)
> 
> I think for consistency, that would have been fine here, possibly
> using another macro.
> 

Something like:

#define __NR_common_offset 110

#define __NR_file_setattr (__NR_common_offset + 469)

Sounds good?
