Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648313AFB14;
	Sat,  3 Oct 2026 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067158; cv=none; b=S4MdH24J92Hm0sQmS5iB8DQNVumj8S6vBFobq+g5w2Tz4EI32B+uR8vMospr2rdHYf+ZbrNB4n1QLilTLQEdnHr8sY/pdFSY+JeXOWqcbeseImrEdjccmC9McpMcrkXwApG/+nA3zPTqPYq5IRq8SReACJnhxBmxygfgAWy6qV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067158; c=relaxed/simple;
	bh=mM2x+uDpO+UABbz7OhrZBCt7w+AxMqVTimidEuhdxCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrXtmg1ayT3gVP+Ot1Zy1tPQo00igB+6T1LobE4KCWgcCizkrG2kNUgY1Q1eniGsKkUEKrRrkgYz8Of+AdEzKUVIjywwOYKgl8LbTn4sWOj6J5q+AH69VMS8LO+OobVmugCOMtJrWzW1Tx/6AQvvIDw+SAnqo5ASkVJAC3ccsOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brhhuAv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brhhuAv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C971F008A0;
	Sat,  3 Oct 2026 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067157;
	bh=LD0jaeF1ZnQ5Ovd+de1oTAfnFIzi65BMQF2xHa38ldY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=brhhuAv2VB8oZxfOVuvgmA6yFAW6njN48bo5lPkTcPnNV+cds2PY3Lnj7ND1d1flv
	 252TNc83t1XXMivUSF4+q3zOEFVuhG9gnkrPElV41hD+2UQ9fohMA0WrLN+XwSi7MX
	 Tw6peK/QWwxmcrt5nj9nTnLgM156CVflwXk5WN9sDOFcjCYfuwLHSe0//Q7ZifSWrL
	 Ohus2pB1CtkFO5Yy2hEIT7OqRR9pU3WmWFlOjiFz8uFx+SndinVWgIzzvLQFoI3z2O
	 GaKO/RKq2KPnWGSHnLJJfyRjClYs2HVsPOEXJ5v7xcbvegk5njfN1oW/Bde6RMRpiQ
	 vzBTPgHiidJcg==
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
Subject: Re: [PATCH 6.1.y] kvm: s390: Reject memory region operations for ucontrol VMs
Date: Sat,  3 Oct 2026 18:33:04 -0400
Message-ID: <2026-10-03-1-daily-reply-0023-re-kvm-s390-ucontrol-memregion-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002194904.21236-1-artem@trailofbits.com>
References: <20261002194904.21236-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 7816e58967d0e6cadce05c8540b47ed027dc2499 ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
