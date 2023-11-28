Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832C28EF;
	Tue, 28 Nov 2023 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyzk5s1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C13C433C7;
	Tue, 28 Nov 2023 01:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701136622;
	bh=oqYXGnK1ocsCHTFu8JJngfoG0AHcjl1dWxjOLuKDfO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jyzk5s1Hvqolnmk0wOY0U/eGf9eb5TNjiw4vRlhE4WC/aXCUofdLkEQJJcHo8ndpu
	 P1h0oExlwE6xGRb1N5acgz4poXfOgl+O4GrbYQt417UBeNKomB4NRy2zn8fIEZTg0d
	 luKk0Qg7hl3dwuYDEtZCH5mMe+e2XqlBUn9pNeo85Tze5jpk2qrJN2yN4MkmaY+Ck/
	 WJFEDmH/5QVg1vFcfVtSnSK40Snw7AdhhkwF7TOOkuFzzZ/Zg7qFGUG2ioYA/qP64b
	 NwVJc0XrtM1zYZDVNDC4dUFLPeOCHsBramZm4du+GBxu5QuAcxSR+/f6PgkJxfzzI6
	 G/HizK3Lvv8ZQ==
Date: Mon, 27 Nov 2023 17:57:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 wintera@linux.ibm.com, dust.li@linux.alibaba.com
Subject: Re: [PATCH net-next v4] net/smc: remove unneeded atomic operations
 in smc_tx_sndbuf_nonempty
Message-ID: <20231127175700.06a2234d@kernel.org>
In-Reply-To: <20231123014537.9786-1-lirongqing@baidu.com>
References: <20231123014537.9786-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 09:45:37 +0800 Li RongQing wrote:
> The commit dcd2cf5f2fc0 ("net/smc: add autocorking support") adds an
> atomic variable tx_pushing in smc_connection to make sure only one can
> send to let it cork more and save CDC slot. since smc_tx_pending can be
> called in the soft IRQ without checking sock_owned_by_user() at that
> time, which would cause a race condition because bh_lock_sock() did
> not honor sock_lock()

Looks like this was applied by DaveM - commit e7bed88e0530 ("net/smc:
remove unneeded atomic operations in smc_tx_sndbuf_nonempty") in net-next.

Thank you!
-- 
pw-bot: accept
