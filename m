Return-Path: <linux-kernel-owner+w=401wt.eu-S1760233AbZCPLYr@vger.kernel.org>
Subject: [Patch] relay: fix signedness in subbuf_splice_actor()
From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 16 Mar 2009 12:24:36 +0100
Message-Id: <1237202676.4210.5.camel@kitka.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tom Zanussi <tzanussi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

The variable ret is used as a signed value.
Found by a statical code analysis tool.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>

---
 kernel/relay.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1227,7 +1227,8 @@ static int subbuf_splice_actor(struct fi
 			       unsigned int flags,
 			       int *nonpad_ret)
 {
-	unsigned int pidx, poff, total_len, subbuf_pages, nr_pages, ret;
+	unsigned int pidx, poff, total_len, subbuf_pages, nr_pages;
+	int ret;
 	struct rchan_buf *rbuf = in->private_data;
 	unsigned int subbuf_size = rbuf->chan->subbuf_size;
 	uint64_t pos = (uint64_t) *ppos;
