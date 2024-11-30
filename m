Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA0154456;
	Sat, 30 Nov 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993469; cv=none; b=cwF7KB7uIyOzifekOt6fksfmEXGLEKAGSq3neeDx6qRnWxyQmx+kulkfXADsmY/O6Dyp02Qgb8ddVurA9HiMPfE0W3kXhqyP5q1F5ozCsoouCWzKdJniKNWYH3L2uRf7ydfXx9+dyP0o/0pBj+1/TCSyluhCqK2115zKu4ZECgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993469; c=relaxed/simple;
	bh=VlCftUdT/0y7LoelM7KAZ8LVO8+zcqqXUerGUNAp3ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSdRXljqz7Mrh1MqjRKRaN5HOOpM9/JKJYVokQt/iHwNJZJ+W9andjEAX0Faj8xl0hCpktKEjqna0/mlXR3f+cCpn6dsoEOPxAlxS0CttBXE0ZrbI4po7EhdW2fxZu2qFVvy8ESwyKtdtHs/yxos+pCoTiZ+1KwUbc7CLkBTdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo7wWZRD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo7wWZRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A69C4CECC;
	Sat, 30 Nov 2024 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732993467;
	bh=VlCftUdT/0y7LoelM7KAZ8LVO8+zcqqXUerGUNAp3ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yo7wWZRDU8NHwuoYtsOV0Le9sZS5n0FYJN+U6d4D8AXmCCcmRbQ+NDIeN558GPXJP
	 8rADoU3y1jYlls+xL5fpkuqzzONVBa3+iALIbdvYq7wsEnFfTRQBb0vAjM8kALHV8C
	 xI2kwkivOKxVRX6zKnJc4QCPKavPh5BmE0pA9ByYfO0GgxajcIB5+s+8clqRwKNGOT
	 O9iSP7Dts7Vdpe2+cTENldkNcPEI4DFCLUDEbgajSWRb6EfkD6VHGT+6Fk0JV1/Yca
	 t/YCIIkO51B5eIKtZe8uAvilcvXfd7hUwkc4K63HuRob1AqaAhhG41yv1bBjHC1ULZ
	 3sZBX8xOiMhgA==
Date: Sat, 30 Nov 2024 11:04:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: liqiang <liqiang64@huawei.com>
Cc: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
 <alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
 <guwen@linux.alibaba.com>, <linux-s390@vger.kernel.org>,
 <netdev@vger.kernel.org>, <luanjianhai@huawei.com>,
 <zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
 <gaochao24@huawei.com>
Subject: Re: [PATCH net-next] net/smc: Optimize the timing of unlocking in
 smc_listen_work
Message-ID: <20241130110425.4610e6b6@kernel.org>
In-Reply-To: <20241130082630.2007-1-liqiang64@huawei.com>
References: <20241130082630.2007-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 16:26:30 +0800 liqiang wrote:
> The optimized code is equivalent to the original process, and it releases the
> lock early.

By a single clock cycle? You need to provide much more detailed
justification, otherwise this looks like churn for no real gain.
-- 
pw-bot: cr
