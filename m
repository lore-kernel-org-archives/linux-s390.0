Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 103/304] s390/zcrypt: improve special ap message cmd handling
Date: Mon, 28 Jan 2019 10:40:20 -0500
Message-Id: <20190128154341.47195-103-sashal@kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit be534791011100d204602e2e0496e9e6ce8edf63 ]

There exist very few ap messages which need to have the 'special' flag
enabled. This flag tells the firmware layer to do some pre- and maybe
postprocessing. However, it may happen that this special flag is
enabled but the firmware is unable to deal with this kind of message
and thus returns with reply code 0x41. For example older firmware may
not know the newest messages triggered by the zcrypt device driver and
thus react with reject and the named reply code. Unfortunately this
reply code is not known to the zcrypt error routines and thus default
behavior is to switch the ap queue offline.

This patch now makes the ap error routine aware of the reply code and
so userspace is informed about the bad processing result but the queue
is not switched to offline state any more.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/uapi/asm/zcrypt.h | 4 ++--
 drivers/s390/crypto/zcrypt_error.h  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/uapi/asm/zcrypt.h b/arch/s390/include/uapi/asm/zcrypt.h
index 42c81a95e97b..494c34c50716 100644
--- a/arch/s390/include/uapi/asm/zcrypt.h
+++ b/arch/s390/include/uapi/asm/zcrypt.h
@@ -150,8 +150,8 @@ struct ica_xcRB {
  * @cprb_len:		CPRB header length [0x0020]
  * @cprb_ver_id:	CPRB version id.   [0x04]
  * @pad_000:		Alignment pad bytes
- * @flags:		Admin cmd [0x80] or functional cmd [0x00]
- * @func_id:		Function id / subtype [0x5434]
+ * @flags:		Admin bit [0x80], Special bit [0x20]
+ * @func_id:		Function id / subtype [0x5434] "T4"
  * @source_id:		Source id [originator id]
  * @target_id:		Target id [usage/ctrl domain id]
  * @ret_code:		Return code
diff --git a/drivers/s390/crypto/zcrypt_error.h b/drivers/s390/crypto/zcrypt_error.h
index 240b27f3f5f6..f34ee41cbed8 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -51,6 +51,7 @@ struct error_hdr {
 #define REP82_ERROR_FORMAT_FIELD	    0x29
 #define REP82_ERROR_INVALID_COMMAND	    0x30
 #define REP82_ERROR_MALFORMED_MSG	    0x40
+#define REP82_ERROR_INVALID_SPECIAL_CMD	    0x41
 #define REP82_ERROR_INVALID_DOMAIN_PRECHECK 0x42
 #define REP82_ERROR_RESERVED_FIELDO	    0x50 /* old value	*/
 #define REP82_ERROR_WORD_ALIGNMENT	    0x60
@@ -89,6 +90,7 @@ static inline int convert_error(struct zcrypt_queue *zq,
 	case REP88_ERROR_MESSAGE_MALFORMD:
 	case REP82_ERROR_INVALID_DOMAIN_PRECHECK:
 	case REP82_ERROR_INVALID_DOMAIN_PENDING:
+	case REP82_ERROR_INVALID_SPECIAL_CMD:
 	//   REP88_ERROR_INVALID_KEY		// '82' CEX2A
 	//   REP88_ERROR_OPERAND		// '84' CEX2A
 	//   REP88_ERROR_OPERAND_EVEN_MOD	// '85' CEX2A
-- 
2.19.1
