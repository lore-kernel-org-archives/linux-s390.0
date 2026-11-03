Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707606;
	b=GG9s/xXF0dQjj+D9lkbquRmVpp0pYWpBl6xtWbnKZqX45dpIKd2/K46h29s7buhg+uxE
	 FBMffX3VFUlCi5rGzeAlpteIb2eiI2P6b4beg4EknSP2ZJNvzsys9F34hx0W4WzdSjF+p
	 BdmXNnn8fgmUek/szYXqBIhmDX2KkgwKaWNq6eZIcbF5/FVAu4gtPkYT981bBn0zMj0Ke
	 hAM8DXYF4m2ZSijXylQ6xvax7vwTgX+wIBN3FDyH9hnVCZ95MBcTIzaMr033t3iF0f9CT
	 JjUNaddWBgH/jvDdA9ZqxEopBB1zNVnppTC4QORSt+pBp+aoJYBNxeLE4GriSmovc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cek6HEj7ZRsXrygLWLXmBmkrl7VVDsBVbmcpW/Faz1M=;
	b=DZYRmKnKQCrDpUI+t7yfbAMn6Tlc1B59l73heFbx8antlEHFPmd7YaC6YF4TlMlDEEHu
	 GLew2PPc1DmXbvrpx72SGjxB3pktlmrVFGSCYqhl5cxmsygLpBMmjdu0FKrHLnCH5IqSp
	 Q2GpJ4GEBWUzFUHaVYXRrIqcRK9UnDPX/OPajlmb+VJuP59KjYR70KE2rx+pZIe7oSHze
	 31kwlKMeRTKCX9Nv2m9DPh9hALGmwL64jY71ct4JgDpG4kFfuvznmCqjPAzrxqD4qeH2v
	 t73ZY9czroKXNwyDIRYNE3GAfy8y+7wajC3kxnyv0TVzTKaI6xqt8cSqFqLwF6K1n5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jX/sZXu4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1B7DC606A326;
	Tue,  3 Nov 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jX/sZXu4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3026D1F000C1;
	Tue,  3 Nov 2026 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707605;
	bh=cek6HEj7ZRsXrygLWLXmBmkrl7VVDsBVbmcpW/Faz1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jX/sZXu4c9x8gP982985jLg041RKGIUysXmLoUeL3zN/2W9c1W1zp/EH490mzLavU
	 vULNaVf9MZV8qhamvca7KLsr2NlHqvM/gRzDHIEGL1PuLssQaQsSD/QB5ewG/NM1vd
	 3/lx1QeKJ/f38A+XWX/qb6sQECTnoxOE8P+oX1XiF8+Z41+BdRvU0Zfghe0dJMFlS/
	 6Gl/IADPnD0hyaIeZJDm5VZNIsQWkmikElcXidi4+owGksZoISrLgUDd2W/L/9/PbE
	 TCY9XYwHPZqyhatE6xpHo4c2RMgdf5ek7GzwLUeuftm4vFANjo9gTH5L1Ew59LlXJz
	 2D2hWjNSGWmWg==
Date: Tue, 3 Nov 2026 14:06:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 06/11] s390/cert_store: Track subsystem keys
 instead of re-registering key_type
Message-ID: <aunOUm3qSnaNTF2x@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-7-jarkko@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103030226.2685251-7-jarkko@kernel.org>

On Tue, Nov 03, 2026 at 05:02:11AM +0200, Jarkko Sakkinen wrote:
> cert_store refreshes its keyring by unregistering and re-registering
> key_type_cert_store_key so key_type_dead garbage collection sweeps old
> keys, while leaving userspace-linked keys behind.
> 
> The removal of key_type_dead will eliminate that sweep.
> 
> Register key_type_cert_store_key once during init before creating sysfs
> attributes, and track subsystem-created keys explicitly so refresh
> unlinks and invalidates previous entries directly.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I would not take this yet too seriously although I've tried to do it
carefully. I just needed to find some solutions for intersection
points, and thus this is more like "WiP" (and patch set is RFC).

I need rework the gist of the whole patch set a bit more than I
first thought. I.e. things like DNS resolver set some walls of
the feasibility of the chosen approach.

Br, Jarkko
