Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1658632B;
	Sun,  1 Feb 2026 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769909493; cv=none; b=HtT1ItYAgnPqlHs6LsiZslMnInQoag7WXuWt/Yak1QNqQ7WyAp4jpURmalDd0veyBBQ4Q4pYSsp69e1sENE1nuT34xKzPWD3ZHqQRJf1L2FHH+WMR0om5KXKYwBSVxfpIipkKnvaXVbbR3ROob3XlXEOqyoBYExhrrmahucIlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769909493; c=relaxed/simple;
	bh=OI2+ZjEerO9520mSekBZhQNARuWw2L9/0GoLGMzgwNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdB5Wev306G4uzccx2FU1fD9e/OApZOhbQaw3sW4lo4jbYEGkKQbkeFIc6omgAkkIg7GOTWWr8MOojsB+Qo7IBD832ky2oSGahrzyES43bav9llW/alDz5C/DJfWE3Zj33XwV6oULCa0GipAPG7SOdkO4TgE1y/Kp/PTEAmS8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xv8SLtQi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xv8SLtQi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rd6MuWHZ6+Qtd9//kOZjteWuHrgO2wc100g0lEmwNGc=; b=xv8SLtQikn54nB/GFh2UJV6U2W
	lVErd+daqcpq5MOsEoWrfduYaXp5RWeR5bagmX+Zl2rfjpGSTjR7g/kkUiJXqHjbJvl0f5SttGnw1
	xawyyW6DEoYmT6zuq2COpbRNNkRYbOzLvtC3lP2x9Trnx0/51egK67AkUDLewukllOQgFluNiyxkZ
	sNGKdBOs2mIGYMJKtm13er4mYOULLidX3PR1yzZJ5PdGCen38fMOHY+0ZoJBStR1LsqwCIcih88Vf
	TLzXbydJsDrYN0wnrPaIwAHJdSBjhq01MkjEPyReXHWrWNSukUm+0cHHRgdE9gO9R3CKUzLzKG2Hu
	TDjo7qrA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmMJF-00000003AHF-35YF;
	Sun, 01 Feb 2026 01:31:29 +0000
Message-ID: <96dba124-fa70-4bfc-9740-232a85f1d36e@infradead.org>
Date: Sat, 31 Jan 2026 17:31:29 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: clean up iucv kernel-doc warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260130054759.1301608-1-rdunlap@infradead.org>
 <20260131131131.0d854805@kernel.org>
 <16c2528a-85be-4f7b-a60a-923613ecc8fb@infradead.org>
 <20260131164920.7e92896f@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260131164920.7e92896f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/31/26 4:49 PM, Jakub Kicinski wrote:
> On Sat, 31 Jan 2026 16:01:04 -0800 Randy Dunlap wrote:
>> On 1/31/26 1:11 PM, Jakub Kicinski wrote:
>>> On Thu, 29 Jan 2026 21:47:59 -0800 Randy Dunlap wrote:  
>>>>   * @path: address of iucv path structure
>>>>   * @msg: address of iucv msg structure
>>>>   * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)  
>>>
>>> In general -- Could we possibly delete the duplicated kdocs in 
>>> the header. As clearly shown by this patch it's double the work
>>> and kernel-doc will be able to find the definition wherever it is.
>>> Kernel coding guide recommends kdoc next to definition.  
>>
>> Thanks. I'll check all of that.
> 
> You probably figured this out but reading back I realize that my
> message wasn't very clear -- I meant that some of the functions
> are both documented next to their fwd declaration in
> include/net/iucv/iucv.h and the definition in net/iucv/iucv.c

Yes, I got that.

-- 
~Randy

