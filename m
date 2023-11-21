Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0185252;
	Tue, 21 Nov 2023 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGgROp8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F5C433C7;
	Tue, 21 Nov 2023 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700562991;
	bh=sIbap2v6n7AnOArLzInMJWDsw+j8c2DedoVdXpTAOBo=;
	h=From:To:Cc:Subject:Date:From;
	b=WGgROp8YyAU8VjOcziWDJ9PgEKudRrshNB0U9vgQLwNky5JObsTBdsV7jQzxwZ7dL
	 9sDkTbL7anK1QBj56V3XFSKbAdU9P7qUHyFos/IQzYHJRArCkHjmwWDRwlNeSfIJkW
	 pLX0kzth4DMtudIGSfK1WmvY7ToLMFTYlsANbRDLdOOkL9YkMUhFwGd/L6v+Fkn/AH
	 pumf6LHi9DvI8aVUrtuHMo/UZm1occPSDAUcTj9SdeMCc2YQDR4ktmVHemNsFHsUdg
	 45FHog4C2FQ9zU4dM/LZFtlQEAR408BAI/Bmcz0C1SNWxWH8cCqxDavix3ubfS+HMR
	 BnC7wI/mD33bQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	David Sterba <dsterba@suse.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jiri Kosina <jikos@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 0/6] tty: remove unused structure members
Date: Tue, 21 Nov 2023 11:36:20 +0100
Message-ID: <20231121103626.17772-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I wrote a little indexer at https://github.com/jirislaby/clang-struct.
And it found there are few unused structure members inside tty. This
series removes them.

Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-s390@vger.kernel.org
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>

Jiri Slaby (SUSE) (6):
  tty: con3215: drop raw3215_info::ubuffer
  tty: ipwireless: remove unused ipw_dev::attribute_memory
  tty: jsm: remove unused members from struct board_ops
  tty: jsm: remove unused struct jsm_board members
  tty: rp2: remove unused rp2_uart_port::ignore_rx
  tty: serial_cs: remove unused struct serial_cfg_mem

 drivers/s390/char/con3215.c         |  1 -
 drivers/tty/ipwireless/main.h       |  3 ---
 drivers/tty/serial/8250/serial_cs.c |  6 -----
 drivers/tty/serial/jsm/jsm.h        |  5 ----
 drivers/tty/serial/jsm/jsm_cls.c    | 36 --------------------------
 drivers/tty/serial/jsm/jsm_neo.c    | 40 -----------------------------
 drivers/tty/serial/rp2.c            |  1 -
 7 files changed, 92 deletions(-)

-- 
2.42.1

