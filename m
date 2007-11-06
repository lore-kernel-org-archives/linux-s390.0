Return-Path: <linux-kernel-owner+w=401wt.eu-S1755532AbXKFVS0@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20071106200807.GC13674@linux.vnet.ibm.com>
References: <20071106200807.GC13674@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm snapshot broken-out-2007-11-06-02-32 - conflict in vxfs_iget ()
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Tue, 06 Nov 2007 21:12:02 +0000
Message-ID: <27341.1194383522@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, hch@lst.de, apw@shadowen.org
List-ID: <linux-s390.vger.kernel.org>

--=-=-=

Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> The kernel build fails on S390, with error 

I gave Andrew the attached patch which is very similar to yours.

David


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline; filename=7861

Return-Path: <dhowells@redhat.com>
Received: from localhost.localdomain [127.0.0.1]
	by warthog.procyon.org.uk with IMAP (fetchmail-6.3.7)
	for <dhowells@localhost> (single-drop); Tue, 06 Nov 2007 14:16:11 +0000 (GMT)
Received: from pobox.devel.redhat.com ([unix socket])
	 by pobox.devel.redhat.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-8.1.RHEL4) with LMTPA;
	 Tue, 06 Nov 2007 09:15:45 -0500
X-Sieve: CMU Sieve 2.2
Received: from warthog.cambridge.redhat.com (devserv.devel.redhat.com [10.10.36.72])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id lA6EFiv2031728;
	Tue, 6 Nov 2007 09:15:45 -0500
Received: from [127.0.0.1] (helo=warthog.procyon.org.uk)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1IpPDe-0004be-Pz; Tue, 06 Nov 2007 14:15:54 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] IGET: Use ino_t consistently for vxfs_iget() and its
	declaration
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com
Date: Tue, 06 Nov 2007 14:15:54 +0000
Message-ID: <20071106141554.17691.1661.stgit@warthog.procyon.org.uk>
In-Reply-To: 20071106022505.f32b1bff.akpm@linux-foundation.org
References: 20071106022505.f32b1bff.akpm@linux-foundation.org
User-Agent: StGIT/0.13
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Use ino_t consistently for vxfs_iget() and its declaration, rather than using
ino_t for one and unsigned long for the other.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/freevxfs/vxfs_extern.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/freevxfs/vxfs_extern.h b/fs/freevxfs/vxfs_extern.h
index f307694..2b46064 100644
--- a/fs/freevxfs/vxfs_extern.h
+++ b/fs/freevxfs/vxfs_extern.h
@@ -58,7 +58,7 @@ extern struct inode *		vxfs_get_fake_inode(struct super_block *,
 extern void			vxfs_put_fake_inode(struct inode *);
 extern struct vxfs_inode_info *	vxfs_blkiget(struct super_block *, u_long, ino_t);
 extern struct vxfs_inode_info *	vxfs_stiget(struct super_block *, ino_t);
-extern struct inode *		vxfs_iget(struct super_block *, unsigned long);
+extern struct inode *		vxfs_iget(struct super_block *, ino_t);
 extern void			vxfs_clear_inode(struct inode *);
 
 /* vxfs_lookup.c */


--=-=-=--
