Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977233998;
	Sat,  5 Sep 2026 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628673; cv=none; b=QX+VMiFgAm/xrdvAKdZTKANnVSjJLi4DUqrrtxpup7WSaV3rJjI4jNCXA6cBxNpnuvXGAMyb6MfGE5a/zUxZeqU7pR6mUxLqmKp2rbfVc1tgbPUs5oHX5nUNRJGgkM0gHYId2w6Q0B3ftT35JU2gwaLEN69aRF+YkIxtZe8nkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628673; c=relaxed/simple;
	bh=w0aohpZKbXpyhrIdRxtL2D3QULqDaeMhKFVMW6v/29k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szc5jn2x/aVcuqUeRswov68sP+FApSOSZl289s6xNK/TfC0Ovi+EEPokOzg9GUuByxK81lL6pIHiZJ7y2zS9zhEE5YwlYKscc1z3ReNqUxk4PBUPR08N1Scrb85VsTcznIo6GjbrDXGoDqToOjUhygKj5qAB2oaS7+AXDqnli0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vyU2ZSaz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vyU2ZSaz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=dtJPlCHH2ndibfZbs2MNLtOWR+finVAxGd3h6Y0oqxA=; b=vyU2ZSaz/bKj/G1c1nt2BlqEds
	X3VQONetwYlXCyoSpjHD9wyq3Q0tA4NkriflNdeA67o69v+1OWR4dFcWUWp/VvFZuGsYpyOBZNKsn
	DiMah7DWUvHbgQNO5WpWWivRLUCG9ynWFFTpSZyGAkXZ8xNEeH9gdhxa12Ho7gg1V2u4Or1XSkQr9
	qw6/3eoQmaIOu+KSw2t/jGzf7tCVQeAyj4LNLeK3oXtYeG4lrNortZuwhUz6jQ2rLSbejoyrRsjQt
	PYxxyC0/+g2CQywOpzyOfH5rRoaVEHKgSIfNLLQfsMQb0dBp1NXJGIcrXEypPiAtNukPum4qdoqsD
	HuI4GBPg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2u1W-00000004HmD-0kqC;
	Sat, 05 Sep 2026 17:17:50 +0000
Message-ID: <6d664fbb-6fe5-47ef-ae06-eeeb4055b969@infradead.org>
Date: Sat, 5 Sep 2026 10:17:49 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: s390: pci: Fix the sriov_numvfs attribute name
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Pierre Morel <pmorel@linux.ibm.com>
References: <20260905091627.40946-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905091627.40946-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 2:16 AM, Karl Mehltretter wrote:
> The attribute is sriov_numvfs (drivers/s390/pci/pci_sysfs.c); the

file drivers/s390/pci/pci_sysfs.c not found.
maybe drivers/pci/iov.c?


> document names it sriov_numvf, which does not exist.
> 
> Use sriov_numvfs.
> 
> Fixes: de267a7c71ba ("s390/pci: Documentation for zPCI")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/arch/s390/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
> index 80f4ba193159..565434626fb5 100644
> --- a/Documentation/arch/s390/pci.rst
> +++ b/Documentation/arch/s390/pci.rst
> @@ -67,7 +67,7 @@ Entries specific to zPCI functions and entries that hold zPCI information.
>  
>    A physical function that currently supports a virtual function cannot be
>    powered off until all virtual functions are removed with:
> -  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
> +  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>  
>  * /sys/bus/pci/devices/DDDD:BB:dd.f/:
>  

With the file name corrected:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
