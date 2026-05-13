Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8E3DDDAA;
	Wed, 13 May 2026 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660720; cv=none; b=Cw/qymq3/tMBpIfXpAQVWh0ENb7RuJtOKHQ3CH4mkRkYPSMXVZtt6bZ0lI2bKpyvz+JiBExQv2TomOi5Ia9s5b0bo53K3DJd5h2xW0Q+jimhdV4Jzj9y0BAfgA8vlqNh42ZwiZtqhb/odbvkO3iHXAxKdcWhBuN1PdRUDAsXE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660720; c=relaxed/simple;
	bh=JSyy9ALiCyMEqHUgm72Z1pM1H2TspwwKOZNdcFHkpVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAS50VRIMYM23WNXEJQuAnYOOzNzqEyZC6EiSQ9AuiouQwEoK5gjKA3FTQ+en4cuwYzrmPED3yXiZIHQ8mWfE+KtsYxGWBYTjOtgdwBIcqs9LdLJGphzpQhtrpvwfHWcaDSdaf8Pyji4d5PpaYTlDPfOLwckqVSE9isvHorzRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqn1PthN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqn1PthN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55645C2BCC6;
	Wed, 13 May 2026 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778660716;
	bh=JSyy9ALiCyMEqHUgm72Z1pM1H2TspwwKOZNdcFHkpVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fqn1PthNCmouQJxTKvEkqa49e9kMbx8ZjW0DPMaVRTHt2es57a1NHg6656ytE5Y7M
	 xfUlnTMPy3688CrHiRphacB3UnSw9Rd/FFODhWJWzedH7CbU3U9Kx833Ld2RVdf9cz
	 JdAeNf76qFa7sPqWzmlBaws5HFKZo1gM4GubR9WymUl3LEN7C5mcyiBNUsMGjw4hA1
	 GbwjDlLVEhbLhwkh418o7kDYLkTBR6AI/kuS00EOtagwohqpURrG5qoZtSTvi6IeMj
	 ssn43wPTrIaX3m/jITvdiN9ItwGAmcWM05JGrRhGJtPzNxgJnEQzdD/eROcidXtsHf
	 biRtcHBE0X85A==
Date: Wed, 13 May 2026 11:25:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/8] sparc/mm: remove register_page_bootmem_info()
Message-ID: <agQ1YS0TJciWts_V@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:29PM +0200, David Hildenbrand (Arm) wrote:
> sparc does not select CONFIG_HAVE_BOOTMEM_INFO_NODE, therefore,
> register_page_bootmem_info_node() is a nop.
> 
> Let's just get rid of register_page_bootmem_info().
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/sparc/mm/init_64.c | 20 --------------------
>  1 file changed, 20 deletions(-)

-- 
Sincerely yours,
Mike.
