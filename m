Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475B230251;
	Thu, 17 Apr 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884907; cv=none; b=s1oCbna9MVeNPRo0yjgcveVxCwFkJ3OkTOOrABunhqaeMFgcyZRP/JAA7t5fF7GzjBSTV+P3A9LcJRFjjarA4MTS7C1f64ZxlnyVqUTmhixFxt5zSs9dZN6bpLXMftpi2i6K633B4sTws35Fz8EJQ8ZPpssWjYmCzAm/2RFKUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884907; c=relaxed/simple;
	bh=pbwCVLNhfKPOc9gMbfPKZcz5S5UWETVCbtkgMLSzAkM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EN4lgiDL51n3dfXWLNT7yr0h5BGOwLd7Zd6hyg3bRj6l5b6JDTHPfa00IGcCN3Ge3PtR5AUb9wA8qRYjepR4qT/CntpM5RmntRPUOGD1zY//LRhoz2VQDuzOFfaYXWNp+uAj47hRpBwUdF/u+ibVZp/NeIKSIcZ45u0Hl0Jqz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5FLQB0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5FLQB0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47776C4CEE4;
	Thu, 17 Apr 2025 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744884906;
	bh=pbwCVLNhfKPOc9gMbfPKZcz5S5UWETVCbtkgMLSzAkM=;
	h=From:Subject:Date:To:Cc:From;
	b=i5FLQB0abspUpVM0MKVowCA8rZVhr8C0e9nMdilfm9Tw+r4j06QwjvatnTmhsVWmw
	 /KCW2U8lMcToBKSjXLk4XWPX9b74Bsi0cZmd3W5t1SK7aQlDA+pr3CwCxjnAAWTnfI
	 IWzdXlYOjEtHsnm9A1bIjIVPdDHOV49eibPOnwX0AiJZ/yiBndsUpzZBCHsfXH2E7K
	 73J8WdVhMMBdUUrWXWWfWnkR95zePyP/MFg30npZZMYKhDQHs+oKMciUt7pZ3SYLCK
	 gann3Mi/EU7uaw8eOXGSipxG5b2c8/nR872A+Y24btWPVHXr4PlON4NxhCNlGqE0U6
	 JkF4hmVehvFeA==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net 0/2] MAINTAINERS: Update entries for s390 network
 driver files
Date: Thu, 17 Apr 2025 11:15:00 +0100
Message-Id: <20250417-ism-maint-v1-0-b001be8545ce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTUAGgC/x3MMQqAMAxA0atIZgMqFq1XEYcao2ZolFZEkN7d4
 vjg81+IHIQjDMULgW+JcmhGXRZAu9ONUZZsaKrGVG3doUSP3oleyEwz9cbanlrI/Rl4led/jaB
 8wZTSB+SBhMNgAAAA
To: Alexandra Winter <wintera@linux.ibm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
X-Mailer: b4 0.14.0

Update the entries for s390 network driver files to:

* Add include/linux/ism.h to MAINTAINERS
* Add s390 network driver files to the NETWORKING DRIVERS section

This is to aid developers, and tooling such as get_maintainer.pl alike
to CC patches to all the appropriate people and mailing lists.  And is
in keeping with an ongoing effort for NETWORKING entries in MAINTAINERS
to more accurately reflect the way code is maintained.

---
Simon Horman (2):
      MAINTAINERS: Add ism.h to S390 NETWORKING DRIVERS
      MAINTAINERS: Add s390 networking drivers to NETWORKING DRIVERS

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

base-commit: adf6b730fc8dc61373a6ebe527494f4f1ad6eec7

