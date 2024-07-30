Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE118A6CB;
	Tue, 30 Jul 2024 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365946; cv=none; b=cQaeQTR4eA1JwAUJl3IyDR7xsBqEalwAH5iYyN3szugKZvRD/1qzUHoWZaCdFm1KB6RmlflLlUqXn0hS5fn6foIEVjHu3zfGHsr44ox9cvdftA9yhsLFON6Vt9UxH1ZNgFeUgiPFkSSz6P+6kVxT0A2cueoMXWjfYBwVLWZPbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365946; c=relaxed/simple;
	bh=bdKsbfhD1pJdC89prLE79NaqtEbG7Q5bbHWqV5HpsNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzLd4OVKaN9FcFg7/TYnVj4dHKEpaDRUXXqsVI1KaSz+sQar9Ioh4/giN7CmEOc066B4MtHEMdz/jSJHFKVnEVLtUMARdiRx1+kKSPCbuBjrUppe9ThbBopN16LD70FJgqU02QA7DfjbRGo+TyllccLJki9u2SdV7xJ6oKRnA3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU+G0bVc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU+G0bVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56130C32782;
	Tue, 30 Jul 2024 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365946;
	bh=bdKsbfhD1pJdC89prLE79NaqtEbG7Q5bbHWqV5HpsNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kU+G0bVclOciYOzTo5j9z9Bv0smvAJzyrrUIeNhrnLV0kN8CD7ZvgptqBmKoK2Ppf
	 a70pI+NB2qscNcfdBgg0q/BmWBD+sEWAN/8PZ6iYMXVPPGCdthhSy+hN+eyGtmAp31
	 PkZe8QigX+KAA4/6Hxz1ePL4TQpu0GhACrv9bibc1BBg3fBm5pjHWXS78pzhf/4N/3
	 zDtPz3kwfBhwJ3P5K0MRvakyRJknhmaiN3Pqly+fCFd0VArjx2RsRJIYvWvVvVpVRr
	 R6L4ccSQEOyP0xKKO/1mnnkpkI5yCjfc3Wk92ek2sja2LyXZLqnT11PjzZPyOHYUyD
	 lLoGw+fNCq2wQ==
Date: Tue, 30 Jul 2024 19:59:01 +0100
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 4/4] net/smc: remove unused input parameters in
 smcr_new_buf_create
Message-ID: <20240730185901.GJ1967603@kernel.org>
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
 <20240730012506.3317978-5-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730012506.3317978-5-shaozhengchao@huawei.com>

On Tue, Jul 30, 2024 at 09:25:06AM +0800, Zhengchao Shao wrote:
> The input parameter "is_rmb" of the smcr_new_buf_create function
> has never been used, remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>
