Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E0466AF5;
	Fri,  7 Aug 2026 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140022; cv=none; b=mRSP58jIwUjUIySxa+H0egK3/Pg/ckV6RHYj3HXEPREMZNdSaoHQLFLrwtrTGS6KD1UevKAgE87+NEZSIEF4plKRBte6qCKFeZTzbyoYzNCIzximOOkr4+IzOBARDJdLo/VMuZg4Kgr3Dfg2PQajSdqE3YqQ01l7YlSq8aSr6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140022; c=relaxed/simple;
	bh=si1yUeFna2C4l1kKsODsKlwh3nOZwQWV9MVqCHYZ1yI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvzI2GSdBAnQG3n4V/gK7t4oXhGpq4+gBOjJ5x13L6L4JtCGGRCayvvd2PtgPguxtKSdATVsWDM8MaCr6eCKkzRnj2vBYWD+ywVSZ46bCHdL0nSuI3LzCqRogtFB5i9I+d1WOly+Pr1iB+QCc2hkIMEa3UcKLLq5Df3eakrEu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXYUS9YU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXYUS9YU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4D51F00A3A;
	Fri,  7 Aug 2026 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140020;
	bh=B5SWajo5tEkt4SNLGphSTPOhLkbb9cyPU+M/cFs4PxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AXYUS9YUTWD8QzhsGY4WBmFuMX1nHTpCNGssvKn0d0VgIhRm0o7oaCZ1ZSAZgAeyd
	 2uvo4s5ppD5V37tVAzJMbq+wu0tlpVJhek8doMeBA2Rguh5ADzwBQ6KchJjHhPPi5e
	 804N2Jmo1onu3HBfvLc/Gg+jFa9lm8UGaqBDjDhiyPrjjhSjK3vMGmg6gmSfPzlCfH
	 YGfbNrKgof3zq47+/kLSpEtyuUxXrvytLpjqEI+qmyLARYEMSQKA5QlMLxmTwXvXlC
	 X86CCDpvF963x13SPAkPJCKbDdOW8yl7inwAkpeFofgQ2OCECpl17pbEFZGvbuq9Iy
	 kJ5HbyrkF1new==
Date: Fri, 7 Aug 2026 15:00:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: hidayath@linux.ibm.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after
 dibs_dev_del()
Message-ID: <20260807150019.22cd70f4@kernel.org>
In-Reply-To: <6464b794-ab0b-4294-b1cb-3de618f4b11e@linux.ibm.com>
References: <20260804085848.3579518-1-wintera@linux.ibm.com>
	<20260806160602.2694608-1-kuba@kernel.org>
	<6464b794-ab0b-4294-b1cb-3de618f4b11e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 16:07:53 +0200 Alexandra Winter wrote:
> > [Severity: High]
> > These are the two failure returns that reach the loopback err_reg path
> > described above: device_add() returning an error (-ENOMEM, or a
> > kobject_add()/duplicate-name failure) and sysfs_create_group() returning
> > -ENOMEM.  In both cases dmb_clientid_arr is still allocated and not NULLed,
> > so the caller-side kfree() and dibs_dev_release() both free it.  The
> > kzalloc-failure case is fine because the pointer is still NULL.
> 
> Same as above (?)
> 
> [PATCH net v2] dibs: fix double free of dmb_clientid_arr
> is in discussion on the netdev mailinglist already.

Please don't expect me to fish out such codependent patches
magically without so much as a note in the commit msg.
You have to repost this, and please do a better job of grouping 
the fixes going forward :/ This is a waste of time for both of us.
