Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618236F439;
	Wed, 11 Mar 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245691; cv=none; b=pohCisolfOaALGSZLJ1rNWwDEfHX2ypg2XyUjM6m8KSgzOjAEgKIViMrD2LzIRn8le2ht/5qt4LZh4cvqoHzASKefBIdW6CfMFelKSdcj06dTpCHKwtJliqwzWNiz5OrIBzMdC44EVaFiX/I746ylswUotsxVx15ZbP4XQiKNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245691; c=relaxed/simple;
	bh=Vj1cq+iuqwG7KXNc1ZX/JifTm+pnU+rOj2V/GKfY+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlHs0d+Ba3/avKa7zSrsVByWeYm3M4+SAzdG/JyoubSbPSyrOF7EDvE/FLeFX/M647bYWRujltKWoa4FJNdmSNwqS61xQ3L3qyNU7U3GQAnHdHBHaEMnVI01MSG7px556jy3sMH/RjMWXcQCzJhJGbwa5H4JSOpxJObRYnUmcpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHRYZRfP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHRYZRfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF88C4CEF7;
	Wed, 11 Mar 2026 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773245691;
	bh=Vj1cq+iuqwG7KXNc1ZX/JifTm+pnU+rOj2V/GKfY+fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHRYZRfPFB8/E/DPdqw4qRYpFNeFMnNq9gPPY06xhTBzPJX4thhJv7VxWAwd6q+X2
	 Le/8noiFhOK7J3DWxxz3c8v4VwY5i9MT7Agb1xWQYuI92kskJZ4JWs0TlpA9lir0N0
	 G0skV2EzFGuXjNJasZX9k0/0SfBQoKj+8/shL4riUnGQFXrn/VWWuVSv1p/ZfQHZLN
	 b0QStdHhw5GuCSeKZzPFG1EOQA1fDDYS7KL1w3wd2n8YehHQLSWNUQv1uWu3U7dq4B
	 dOm9Sd1VqRUk0ADGsXb3jwh/0BnGx1t/449KIVUKdWhdugrjtiGlhXjg+z5PM9h1NQ
	 tUZLQoBjyymiw==
Date: Wed, 11 Mar 2026 17:14:48 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] s390/idle: Remove idle time and count sysfs files
Message-ID: <abGU-Bt6C-tbgjYQ@localhost.localdomain>
References: <20260225145146.1031705-1-hca@linux.ibm.com>
 <20260225145146.1031705-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225145146.1031705-4-hca@linux.ibm.com>

Le Wed, Feb 25, 2026 at 03:51:46PM +0100, Heiko Carstens a écrit :
> Remove the s390 specific idle_time_us and idle_count per-cpu sysfs
> files. They do not provide an additional value. The risk that there are
> existing applications which rely on these architecture specific files
> should be very low.
> 
> However if it turns out such applications exist, this can be easily
> reverted.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
