Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A23306744;
	Thu,  6 Aug 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021364; cv=none; b=Z19wi+DNqYN4iI/OocNRJJsRpIdiHbOPVwdQJNj+WtpyVuw8uo057u0EExtmsUAty7PkhbpZjRR7iFmZcfgVhceDivtSKjXByS6ICK0RBASTSJ8wxJfSFu8Yl7NmLMQ4XCjh+BHgMOkWhKBZHP7J54cIY0RIbVKNjbLdEU8hLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021364; c=relaxed/simple;
	bh=SqrcTvuV/0D7PqQZ8A2wsELUsup5xSQV82HEAqk17cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQuuyRA+624tie9cXx+502wZX3HE/IE1+GGPD9GeEW7vEosAW59fL1WzMwhM0gdS3hdNxXqOT3bbRkpKOsDgOT8uU0va8YZ+SWCZiO/kaWocYvFh5C5ng74Mc3VaO5BDY1le1HQJwYMnk1DBuSln/pdTBV0EGMA/UZLAfqiU4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdmP2WIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdmP2WIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DDB1F000E9;
	Thu,  6 Aug 2026 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021362;
	bh=REKdmea96z526a+0NUIpG6wRx2+DCKbDCfGqPIKFQCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WdmP2WINsRrooeolI+/9+8hpP/fPOFukQQQX1fqvl1BDlnS4knj7j9TDCQXMhc5fv
	 MpbzlPIi+eLfZtQ1vwDkG7rRPXoVmPQJdR7SbKqxLrUmll63LUXVYnsypBNdcI2y+b
	 KyERFB9iS/YJivRBCDtQiRQCS7fwzgSGEjgcBbv4KK2bLxSKydp72ElhsNa0O6BZhh
	 1TWIE1Y8dcZApWRTUHJiC+Ip5sc/p5HB9HEyeMk2PnG7gWX5lOdQ6KzZaXXszRlk09
	 1tGcOLD/xM9BuNai1pvl6v5Aayo3KfhH3ExxtSj/ATp26nbl1j6+fkXyiFviXVG0Zn
	 aMhT4aGhZET0w==
Date: Thu, 6 Aug 2026 14:02:37 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after
 dibs_dev_del()
Message-ID: <20260806130237.GB51943@horms.kernel.org>
References: <20260804085848.3579518-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804085848.3579518-1-wintera@linux.ibm.com>

On Tue, Aug 04, 2026 at 10:58:48AM +0200, Alexandra Winter wrote:
> A dibs device interrupt handler can be active after dibs_dev_del() and
> may still access dmb_clientid_arr.
> 
> Free dmb_clientid_arr in dibs_dev_release() after last reference is gone.
> Note that allocating in dibs_dev_add() instead of dibs_dev_alloc() is ok
> for now, because no dmbs can be registered before dibs_dev_add().
> 
> Fixes: cc21191b584c ("dibs: Move data path to dibs layer")
> Cc: stable@vger.kernel.org
> Co-developed-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

