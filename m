Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B313242D7;
	Mon,  2 Feb 2026 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770070076; cv=none; b=AX//4Uiz0Ri/iJzYrcJGL69Mod3P3LcZAfr5tIgw6iG+e6/elQmKlxDH9p+t3MRO2tGzvWl+VFo4Id4KqZ5jZj483DIebTFqlSWACNu1fhObKgGVodwUKT/IEf4zyp9ODbd/3CDrIALt5RtEAdg1ZpwRavmQ3PNN/49bYz20cD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770070076; c=relaxed/simple;
	bh=bnqz5Lg6zNKkWyFFDbFNMuu1DFfsTzpptKhA1xhLbYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDr6GmbHrS0KthF0I1t//77gfhymM/kMHo1Lop8SpUuPAB1SSf7+C2NOxyS3KtqkpBNHvYxV2ectJp2PTBUSFqhY6L+Zj6cf+C+ezEptR61YAp6LlJtYkglNaBggLoYFI6jzXx6C+ufM1CbRPOHaUYoqTeBjum0Gok28K71x08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0VGAEeMQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0VGAEeMQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tQeInzoDicgl882XpJgNlflAuI9sUNfJX9nLKOj1C6U=; b=0VGAEeMQq9zyPoVeCSBkEdtC1b
	IyATzwMpgVSpweaqcrhV45DJMFaK8BGy6taCJ3kfc5O0tGd1fyOK+bVZiykflvhRHwJffw5DOcqiI
	8zN4qf53qI7I1D5dUPUnx31er1WJzEuf8e4k9OggbUJdkrddZHmpC3rkEhYQE7kg2qyai5E6/7b4n
	6ooPCHL/zX3QWjOELoDMUd49WgSWf9/gTc2oRzYBlrZcRmF18nsY/fbKh8T6MSLr/NVg7157hhIon
	tE3eq6eU5vEw7VDTw0LTmX8TT9Q8HUw88la6Rvh8hQ0QjS2dr+OWk1n8Xydg4/uRbn7EJusPAAE2x
	zAMNh1eQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn25I-00000005goZ-0Nzk;
	Mon, 02 Feb 2026 22:07:52 +0000
Message-ID: <136674a3-cf8d-4da9-a82d-d0edea6aca03@infradead.org>
Date: Mon, 2 Feb 2026 14:07:51 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/iucv: clean up iucv kernel-doc warnings
To: Alexandra Winter <wintera@linux.ibm.com>, netdev@vger.kernel.org
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260201072309.222155-1-rdunlap@infradead.org>
 <2ddf6abd-d10c-4d75-8f84-0fd1ccb5435c@linux.ibm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2ddf6abd-d10c-4d75-8f84-0fd1ccb5435c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/2/26 7:35 AM, Alexandra Winter wrote:
> 
> 
> On 01.02.26 08:23, Randy Dunlap wrote:
>> Fix numerous (many) kernel-doc warnings in iucv.[ch]:
>>
>> - remove kernel-doc on static functions in iucv.c
>> - convert function documentation comments to a common (kernel-doc) look,
>>   even for static functions (without "/**")
>> - use matching parameter and parameter description names
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
> 
> Thank you very much for your effort Randy.
> FYI: I had to use 'scripts/kernel-doc.py -none -Wall include/net/iucv/*' to see the warnings.
> 
> 
> 
>> v2:
>> - correct verbs in descriptions of 2 functions (Jakub)
>> - removed duplicate kernel-doc comments from the header file (Jakub)
>>
>> Cc: Alexandra Winter <wintera@linux.ibm.com>
>> Cc: Thorsten Winkler <twinkler@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>>
>>  include/net/iucv/iucv.h |  209 ------------------------------
>>  net/iucv/iucv.c         |  259 ++++++++++++++++++--------------------
>>  2 files changed, 128 insertions(+), 340 deletions(-)
>>
>> --- linux-next-20260130.orig/include/net/iucv/iucv.h
>> +++ linux-next-20260130/include/net/iucv/iucv.h
>> @@ -70,7 +70,7 @@
>>  #define IUCV_IPLOCAL	0x01
>>  
>>  /*
>> - * iucv_array : Defines buffer array.
>> + * iucv_array - Defines buffer array.
> 
> Did that create a kernel doc warning? It's a struct, not a function.

It's not kernel-doc, so no warning.
However, JFYI, for kernel-doc, it would need a "short description" after the
hyphen, whether it's a function, struct, enum, typedef, union, or define (macro).


> I propose
> + * struct iucv_array
> like other structs in this file.

OK, that's fine for structs that don't have kernel-doc notation.

> [...]
> 
>> @@ -757,13 +742,12 @@ static void iucv_cleanup_queue(void)
>>  }
>>
>>  /**
>> - * iucv_register:
>> + * iucv_register - Registers a driver with IUCV.
>> + *
>>   * @handler: address of iucv handler structure
>>   * @smp: != 0 indicates that the handler can deal with out of order messages
>>   *
>> - * Registers a driver with IUCV.
>> - *
>> - * Returns 0 on success, -ENOMEM if the memory allocation for the pathid
>> + * Returns: 0 on success, -ENOMEM if the memory allocation for the pathid
>>   * table failed, or -EIO if IUCV_DECLARE_BUFFER failed on all cpus.
>>   */
>>  int iucv_register(struct iucv_handler *handler, int smp)
> 
> Before this one, you changed /** to /*
> after this one you left /**
> That's a bit inconsistent.

That's described in the patch description:

>> - remove kernel-doc on static functions in iucv.c

but I can restore the "/**" (i.e., not change them to "/*").
OK, I'll do that.


> 
> All the fixes look good to me. And they get rid of the mentioned warnings.
> I appreciate your approach to use the existing wording, though it may not
> be according to the latest style guidelines.

Is that IBM style guidelines or kernel?

> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


I'll send a v3. Hopefully it will be satisfactory.

Thanks.
-- 
~Randy

