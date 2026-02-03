Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27D201278;
	Tue,  3 Feb 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143458; cv=none; b=rKOgJksZa8oAaIhCNR/SvpVDHOB3TPSKS+Q8Ip7kp8jydTsf3dBks3QhIzeiEMTT+ror0vfiUBTaZoH34eOyi5y6P60NygFF0C9ilJQDIam54uusoyKeyq5lh6WN/LH8KK6STJ7QzswAC/BFwhJsxEHMKdC/TXSHRY8m4n3JO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143458; c=relaxed/simple;
	bh=9NWxoO5o6T4XXoS9WMINlIyf76U9dN0lGsOy4DDJu+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3YQ3E54j7TG0UofdllTludoQnFk8e0X+lfBIpx0bQ9NPGEjFOw8/FXIm3LBjjNgI+cYRjFxQSkqFhFRj6rvQsISHZ5OH/uhSEgBpUIYtszP57w5X49201OzsolUTyXxdtuWsWgpOqFQjW96KsWEWvzbVxRRpF5kO0hTeyItNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B+Jh8YEb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+Jh8YEb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RwA5o68pjd0kIaDQ2P+vDFqAK790PV5GlCTgY10amXc=; b=B+Jh8YEb9AsmboUijZxE6zsORF
	MQhAtxSI7M3qBeYzMEzy7gScX4CpmsjZ5sOW0rC6ukujM1GzshDNkPpyeA0YgRT4Q+/e35fr/55mX
	6mNFcN31wmHINX2rbKzCnP2LaWC/WJiJ0dUzNc2zozkB4JuZ9eOMHV8CelA7nKhZeyuk+RPktsWd9
	CU5g1XVaSBZv2Ye7aPF3+LoNVzuPO/CoFzYT92hqg/Y7ASYpySub2TcmsZ2MgDbGYUUERA2fRsP9r
	8V3OL3BYu9QQK8mzHMkIcGPdkmsaSexLEU4jdZs5jND4MJk4meHWWE+spmEgCd5M+oHVlmb/fEXCp
	EG+BpQgw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnLAs-000000079cu-0Pzj;
	Tue, 03 Feb 2026 18:30:54 +0000
Message-ID: <2dfeee9a-ea5e-4f8d-822e-d7ee84544c5e@infradead.org>
Date: Tue, 3 Feb 2026 10:30:51 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net/iucv: clean up iucv kernel-doc warnings
To: Alexandra Winter <wintera@linux.ibm.com>, netdev@vger.kernel.org
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260203075248.1177869-1-rdunlap@infradead.org>
 <04ce261c-2cef-4575-8e2d-e13391c2a933@linux.ibm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <04ce261c-2cef-4575-8e2d-e13391c2a933@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/26 1:39 AM, Alexandra Winter wrote:
> 
> 
> On 03.02.26 08:52, Randy Dunlap wrote:
>> Fix numerous (many) kernel-doc warnings in iucv.[ch]:
>>
>> - convert function documentation comments to a common (kernel-doc) look,
>>   even for static functions (without "/**")
>> - use matching parameter and parameter description names
>> - use better wording in function descriptions (Jakub & AI)
>> - remove duplicate kernel-doc comments from the header file (Jakub)
>>
>> Examples:
>>
>> Warning: include/net/iucv/iucv.h:210 missing initial short description
>>  on line: * iucv_unregister
>> Warning: include/net/iucv/iucv.h:216 function parameter 'handle' not
>>  described in 'iucv_unregister'
>> Warning: include/net/iucv/iucv.h:467 function parameter 'answer' not
>>  described in 'iucv_message_send2way'
>> Warning: net/iucv/iucv.c:727 missing initial short description on line:
>>  * iucv_cleanup_queue
>>
>> Build-tested with both "make htmldocs" and "make ARCH=s390 defconfig all".
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> v3:
>> - I didn't use Alexandra'a (v2) Reviewed-by: due to the number of changes.
>> - leave kernel-doc ("/**") on static functions in iucv.c (I did not
>>   convert other static functions to kernel-doc comments.)
> 
> Thank you. Feel free to add
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> 
> There are still warnings left about missing return value descriptions:
>> make W=2 clean net/iucv/ 2>&1 | grep ^Warning
> Warning: net/iucv/iucv.c:691 No description found for return value of 'iucv_sever_pathid'
> Warning: net/iucv/iucv.c:1099 No description found for return value of 'iucv_message_receive_iprmdata'
> Warning: net/iucv/iucv.c:1856 No description found for return value of 'iucv_init'
> Warning: net/iucv/iucv.c:691 No description found for return value of 'iucv_sever_pathid'
> Warning: net/iucv/iucv.c:1099 No description found for return value of 'iucv_message_receive_iprmdata'
> Warning: net/iucv/iucv.c:1856 No description found for return value of 'iucv_init'
> Warning: net/iucv/af_iucv.c:131 No description found for return value of 'iucv_msg_length'
> Warning: net/iucv/af_iucv.c:150 No description found for return value of 'iucv_sock_in_state'
> Warning: net/iucv/af_iucv.c:163 No description found for return value of 'iucv_below_msglim'
> Warning: net/iucv/af_iucv.c:889 No description found for return value of 'iucv_send_iprm'
> Warning: net/iucv/af_iucv.c:131 No description found for return value of 'iucv_msg_length'
> Warning: net/iucv/af_iucv.c:150 No description found for return value of 'iucv_sock_in_state'
> Warning: net/iucv/af_iucv.c:163 No description found for return value of 'iucv_below_msglim'
> Warning: net/iucv/af_iucv.c:889 No description found for return value of 'iucv_send_iprm'
> 
> Our team will fix those, unless you want to add them to this patch.

Please go ahead with those fixes.
Thanks.

-- 
~Randy

