Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FB4DB559;
	Tue,  9 Jun 2026 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032570; cv=none; b=FNXazdYf6xTgVyRs4p2qgSw9EoSiiKr3ac4NAVkQ24x6PdCJ5W7/Ru9cW12LAyIAOKv6J06MRG+fi7wk+sTYtYZq30XZ8WhQZ/0ZT4jQLsVM6sghVT6g3iIZ0jcxCTMxTdTk07l6mlsaFDyq3j4oxvfoWhKRGTxclK9RmQOw5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032570; c=relaxed/simple;
	bh=2dXul6EpZQ3L1XNvuNJqNmx+Wvf31tYng7dRqPDdLsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzUsGS9G/wTnlz1prvTB4qEOpvR6tRfHE1NwETXN5FSovsa0vGaBKYG5P7E70jiVXURuLBeXSFOTjy74bN/RnX3SFS4UKCJJuxJJz8RufRTHsoVoKMkHka2pCZ11lszQROl6w3NzKRIJSehsuu7eJTSIJPm7kqCZg0Hn5Ke/GKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=L08ajDIL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUWe2h4O; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="L08ajDIL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUWe2h4O"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EC7F2EC022A;
	Tue,  9 Jun 2026 15:16:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 15:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781032566;
	 x=1781118966; bh=rN3rdmRzxAU6hb2xvro1GlJdcdDmOfuaXwfPA/DRbbs=; b=
	L08ajDILMl9TdrjtO2ZP3P39yrkZNQscPZmwiYryDck77kabbKLDWZ4/501v+OtD
	81K324fknDtNerzdz7fXjxAk1yAurT1TM8+qLksgcRdS2UJAZTPvQNHjCm7Nl/90
	XoqTFjvKiC0cf1oeCMWyPhkTNNb5AEG4cL4RzTYdOQPBU7z+D/1aotAYQTQGQktm
	PG7tQldFU3nidZe0AEHB7NEbK/5mPrTp6mGh6IsdrBNlb2Na0bzPM0gUt+xjhmDK
	5BjztfpjQfhUcmlO8JPcmda7SUfkLytWZKtTboTPRmJmaAsFEuEKRHKwzPD1I8hH
	Q+wJ5jY9MTQbuZBiwTSvIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781032566; x=
	1781118966; bh=rN3rdmRzxAU6hb2xvro1GlJdcdDmOfuaXwfPA/DRbbs=; b=c
	UWe2h4OVQ0Eafr0nntwTJlWEBcfQM+xRDj78ILMpZSYOAGaQmjcEOjZvR1lM3vVR
	ccUUWcnnqQLy9EoDDVNs8P/c29M5LX/A9W5hcBlTbGwtKoJb2twwUKuiy371CC5i
	ln26nA1x/DBJruenM+bF+eJZzKDtsLOnKrJ8i1S2SIGpWvS5SUwmqCQdwxBRIX+O
	GThZE4zF7MqALK1jgYZ/ECpNXP3EJqUVvmLgs7S3o+Dfs9htti19l7lTsosj9Su1
	HEMZSG5aL9byYj5eGOvoJ0kFlLjgZnjkt0e/611piVHERJtXMUrufmzbsP6in1ti
	IPvjtD1dXXFjPtro/r+Mg==
X-ME-Sender: <xms:dmYoatEP4f1ewXbKgCZfOZuzPGfw8_0bU_A-dZytB4irB5IFzWkgQQ>
    <xme:dmYoaosAIHJ8mUK5N6HWhkqFN0paf0ycCR9bJvevqaoABjtqt8sNv1djpII7lWlVW
    afoqOS1qZAh0p7ROt1a3zvHyQ4CDX_apBMfxDI-OwEhqYLUSVzMBEo>
X-ME-Received: <xmr:dmYoarY-Md94DrAbJ632tAimP0NJ_MW4BDBi2wSY9HSeejByH8y0JmeLkZw>
X-ME-Proxy-Cause: dmFkZTFlC78n8oVY6BtWDnhxBMBGpkz2Mq4ap945DixZqO4SIR4z2ozKrwF+6ZeRVD9zWe
    XpCjg/77uAgo7bj/JfC/ffad2QfN98gYTtkNsC3Ef8nSoOQcO8UO6h6zGgM5cJT0Q/l44r
    B5frmpNAO3O93VbmJkZHdeE+X6Z90fupx2Kmu6r+jkQh3jC3GdIOEuJxtlmmqd97ZpHZ5V
    nxS4e1AEfBYjYqoehStGIX+4Xiu9jIgALkvVcQo7ZXDFAkROl1WjvqyTG2xh4E/1O2wXu9
    fD4EJFI55Yu78xBsUKgLGr5V/zHWTJ4xotrg7DGN3wS1vIbxTYm8+M2bPmL10FJJKSn3sR
    jqlU3sMxjSTR1HgvqFS1AJ1Isz4iYmrCrJgZm2u+Wh/X+c2FK2RuXK5Kww+BWS8Kzvjc3E
    0Pit/DqnIrEnZ4195w6vWK2x6mCx2OBZu1+2CCFaA6ouHjeuOsrKpdygYDVfIkamEOmb+m
    imNX/vx3nEZcW2uaFWZlYfYEZN3grDr0WBd8n6fxsVz84LoVfw7Q1SrNyeyXp1lGodjFxC
    vPYjxbWv2aQ2Ln8095F2KKBzpGoBtmQRXbVd2FqqUFBgUddAlZCxPmxu1WooEot3lkALhv
    1NUUYz7W1+gOX7wmBzvJclEshG13ZLVKQ4R1vz0kwxBybmiwFj9/5RQy0Ipw
X-ME-Proxy: <xmx:dmYoag7XhE9-vyYbcT_BM48PSZemQMIZBTG-LKVnI9Let5HVwlQKkw>
    <xmx:dmYoar8vmDJq65kvIGQw_Ldb3l2oevvL_iBF9LdaicW_VpH2GI46nA>
    <xmx:dmYoakY6cPm0ggu4pq7H51idNd0Bs6_9UsFWFpVOsDlX2Jf88uBDUg>
    <xmx:dmYoas6Wme8YfOiWKY6K0X0sh3htEmQYfMjNJ3uRgF6p85vx3DFAGg>
    <xmx:dmYoakymOxvEtNy4RQclknFmo0GHAHx4Uq1RMEUWyeY9XzA_sjTQGJ8L>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 15:16:05 -0400 (EDT)
Date: Tue, 9 Jun 2026 13:16:04 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 helgaas@kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com, Julian
 Ruess <julianr@linux.ibm.com>, Chengwen Feng <fengchengwen@huawei.com>,
 alex@shazbot.org
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for
 vfio-pci driver
Message-ID: <20260609131604.227218e8@shazbot.org>
In-Reply-To: <96c749ba-1b42-425f-8767-a3fce4a4d30b@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
	<20260603182415.2324-4-alifm@linux.ibm.com>
	<aiE3I0bL0TX1nOec@kbusch-mbp>
	<d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>
	<20260604135717.5dc69583@shazbot.org>
	<96c749ba-1b42-425f-8767-a3fce4a4d30b@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 12:26:36 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> On 6/4/2026 12:57 PM, Alex Williamson wrote:
> > For things like MSI/X, SR-IOV, RE-BAR, etc. we're actually restoring
> > from the kernel internal state rather than the save buffer state, so
> > this is a no-op.  However, one thing in that list stands out, TPH.
> >
> > We don't yet support enabling TPH, but there are series on the list
> > that propose to add this.  The TPH buffer space in the saved state is
> > allocated just by the capability being present.  On open TPH is
> > disabled and the saved state is untouched, zeros.  If TPH is then
> > enabled and the device reset, the pre-reset save state populates the
> > TPH save buffer and we restore that state post-reset.  With the change
> > here, reset_done would then push the open saved state.  The live TPH
> > state is enabled, therefore the restore pushes the original open state,
> > zeros.
> >
> > This would result in a visible user change and maybe more importantly
> > shows that we're relying on ad-hoc behavior, without really any specific
> > policy to have this work reliably.  It actually seems like only in the
> > close function, where we've disabled anything the user might have
> > enabled, is it really valid to restore the original state.  Thanks,
> >
> > Alex  
> 
> I was trying to see if we can remove the callback and still restore the 
> device. The original reason why we wanted the callback, was to restore 
> the device state into something sane[1]. Since commit a2f1e22390ac 
> ("PCI/ERR: Ensure error recoverability at all times"), which removed the 
> saved_state check from pci_restore_state(), we will always restore from 
> the last saved state. However, the last saved state in vfio can have the 
> Command register Memory bit disabled (for example could be done through 
> vfio_pci_pre_reset() in QEMU). This becomes problematic when we try to 
> restore MSI-X from in kernel data and when MSI-X is enabled. AFAICT the 
> msix restore path doesn't check if the Memory bit is enabled before 
> writing the MSI-X message, which could cause an Unsupported Request 
> error from the device. From my experiments, enabling Memory bit before 
> restoring MSI-X state was sufficient to get the device in a sane state 
> without this patch.
> 
> So we could remove this patch. But maybe there is a gap in MSI-X 
> restoration path?

I'd say yes, that's a gap in __pci_restore_msix_state() that it's
writing to device MMIO space under the assumption that the device
entered save/reset/restore with memory enabled.  It should really force
memory enable to be set around the access and restored after.  Thanks,

Alex
