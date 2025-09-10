Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7C7494
	for <linux-s390@vger.kernel.org>; Wed, 10 Sep 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514873; cv=none; b=NBbAIXlT8IBpiX0K9baWpcdG5++A/J5nydCRkm+FjYUU+rdNoC1RWbDvooJR6BIYta8uiUmRFfHmQYhXB/Z4quCW5dh/7GsfUFwarxA+7pHHAvK59Uph+PSfoJBol/O099mZFjTKVMWmbL/jdJQazfiwxPHjmvFSZXWYbxEU7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514873; c=relaxed/simple;
	bh=kPzGLA4SZw5UAqzJ2RcglIRHA3YYBSdEJrmsnFRP0Hs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LBL6ZzdagLVMqfDZUX9HZylT3WdX311PchlrXkadd2QvPkR6vWD5DiME7WKwKujfYDuZS4sDkDQVR4cLotb/7bvFWcKVCoY2jD9B59tFD6O4Q58lNmmZf0aTbwXAkhryEI02XKd9xTDf0OaLSPz/EvX41W4rwia9fpCMLcQA+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qIpS7Lvy; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qIpS7Lvy"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757514859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPzGLA4SZw5UAqzJ2RcglIRHA3YYBSdEJrmsnFRP0Hs=;
	b=qIpS7LvyBAUfyvsbOTdcfzW2n/zeC1lqza3tt2crAHXwG/SYPtJHLAPkFZIizcAEPgNQ8q
	u4mXXAwWNK0I4O0PFkZ+QkcR371PFU3MktJSOaqXNczdP4NMIYmXjA2ev+wpJ2lNszPZJR
	SpUPuSNbGM3zyhdwD8vdd4lxBoHs/ZU=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] initrd: Fix unused variable warning in rd_load_image() on
 s390
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250910095237.9573B41-hca@linux.ibm.com>
Date: Wed, 10 Sep 2025 16:34:07 +0200
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B3D03364-B03E-40C8-AC1A-A31C32263323@linux.dev>
References: <20250908121303.180886-2-thorsten.blum@linux.dev>
 <20250910095237.9573B41-hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 10. Sep 2025, at 11:52, Heiko Carstens wrote:
> Instead of adding even more ifdefs, wouldn't it make more sense to get
> rid of them and leave it up to the compiler to optimize unused stuff
> away?

Yes, I'll submit a v2.

Thanks,
Thorsten

