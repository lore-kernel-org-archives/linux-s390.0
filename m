Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A9517BBE;
	Thu,  1 Oct 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862771; cv=none; b=TzBeWYQQa7wVLkqnvBt3ZAw7YAV6IijensB4EjUd9im9QrIfbu2Y0ZSOsjkxctSZgENKkFQ1CDHbkc/GHYnlRKl8I7Mo4WqmGtiNFPrqnDiUnNRKDx/9lz++ceE4PrH1MfpykU0eqSYYJFAVL9kb4ZRxCM96E4DB7QV3x1FDGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862771; c=relaxed/simple;
	bh=umMm/lPHi+t6I0OV+oiw1mqotwWKf/PFzTIWE/oehD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MACjUgZzNk6q+fCi/jwsh92zQwbFvBJJXHvo8GKwiEqV5XB42yFIRVxZGWGMKcMGzqBI1Oe8sqkzZQgaXr7M4AYAcOC1992UkxX14NQ/K4g3in6Go63V30pTplaxKPTCbcfXPbantF+VZ9gVborXNDBpaq+Yd6dW5PGW5QTY6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pby8+liv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pby8+liv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC831F00898;
	Thu,  1 Oct 2026 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862762;
	bh=xzjj40ZRCj8ePrqYusGZlHY502YuOXd8N/PhFe182tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pby8+livbzPijUL6F+BG9QMZ0Jf7qAdFX04IyC7J1tg04EpOJCduBgjFntCw9cTBZ
	 MQsMBXcp8kvZCK90ZwJaphKg48Fm3GYh3Dly1nnEsmzGVrwQjTd/0tGXg+nvtWr5JW
	 cFtFoicBHelQTw03fS6iB5yeZTOLofhKYD992EGBwv9xKCybGDp/UeB1de0O+qeqMf
	 ovslBqmMa3NIgjbwIA1JgrBsG2jdpqCinJl7konAvUq38z2rPKLnS1MSc+l588W6qG
	 XWtIzTvY3pSLtjeHlrnLxWc7iiXRvcSXDWzkJqi9v9rcVOWQUgOPRQh60I1Z9x6bYx
	 UWH8xdcLYReEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	avi@redhat.com,
	cotte@de.ibm.com,
	david@redhat.com,
	mtosatti@redhat.com
Subject: Re: [PATCH 6.6.y] kvm: s390: Reject memory region operations for ucontrol VMs
Date: Thu,  1 Oct 2026 09:52:15 -0400
Message-ID: <2026-09-30-1-daily-reply-0011-kvm-s390-ucontrol-memregion-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930011211.94657-1-artem@trailofbits.com>
References: <20260930011211.94657-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-43819. It rejects memory-region ioctls before a
> ucontrol VM can dereference its NULL gmap.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
