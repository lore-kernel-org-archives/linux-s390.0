Return-Path: <linux-kernel-owner+w=401wt.eu-S1758757AbXJDLlR@vger.kernel.org>
Message-Id: <20071004112828.689566148@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/34] zcrypt: remove duplicated struct CPRBX definition
Content-Disposition: inline; filename=015-zcrypt-dup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ralph Wuerthner <rwuerthn@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_pcixcc.c |    2 -
 drivers/s390/crypto/zcrypt_pcixcc.h |   45 ------------------------------------
 include/asm-s390/zcrypt.h           |    4 +--
 3 files changed, 3 insertions(+), 48 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -277,7 +277,7 @@ static int XCRB_msg_to_type6CPRB_msgX(st
 	};
 	struct {
 		struct type6_hdr hdr;
-		struct ica_CPRBX cprbx;
+		struct CPRBX cprbx;
 	} __attribute__((packed)) *msg = ap_msg->message;
 
 	int rcblen = CEIL4(xcRB->request_control_blk_length);
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.h
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.h
@@ -28,51 +28,6 @@
 #ifndef _ZCRYPT_PCIXCC_H_
 #define _ZCRYPT_PCIXCC_H_
 
-/**
- * CPRBX
- *	  Note that all shorts and ints are big-endian.
- *	  All pointer fields are 16 bytes long, and mean nothing.
- *
- *	  A request CPRB is followed by a request_parameter_block.
- *
- *	  The request (or reply) parameter block is organized thus:
- *	    function code
- *	    VUD block
- *	    key block
- */
-struct CPRBX {
-	unsigned short cprb_len;	/* CPRB length	      220	 */
-	unsigned char  cprb_ver_id;	/* CPRB version id.   0x02	 */
-	unsigned char  pad_000[3];	/* Alignment pad bytes		 */
-	unsigned char  func_id[2];	/* function id	      0x5432	 */
-	unsigned char  cprb_flags[4];	/* Flags			 */
-	unsigned int   req_parml;	/* request parameter buffer len	 */
-	unsigned int   req_datal;	/* request data buffer		 */
-	unsigned int   rpl_msgbl;	/* reply  message block length	 */
-	unsigned int   rpld_parml;	/* replied parameter block len	 */
-	unsigned int   rpl_datal;	/* reply data block len		 */
-	unsigned int   rpld_datal;	/* replied data block len	 */
-	unsigned int   req_extbl;	/* request extension block len	 */
-	unsigned char  pad_001[4];	/* reserved			 */
-	unsigned int   rpld_extbl;	/* replied extension block len	 */
-	unsigned char  req_parmb[16];	/* request parm block 'address'	 */
-	unsigned char  req_datab[16];	/* request data block 'address'	 */
-	unsigned char  rpl_parmb[16];	/* reply parm block 'address'	 */
-	unsigned char  rpl_datab[16];	/* reply data block 'address'	 */
-	unsigned char  req_extb[16];	/* request extension block 'addr'*/
-	unsigned char  rpl_extb[16];	/* reply extension block 'addres'*/
-	unsigned short ccp_rtcode;	/* server return code		 */
-	unsigned short ccp_rscode;	/* server reason code		 */
-	unsigned int   mac_data_len;	/* Mac Data Length		 */
-	unsigned char  logon_id[8];	/* Logon Identifier		 */
-	unsigned char  mac_value[8];	/* Mac Value			 */
-	unsigned char  mac_content_flgs;/* Mac content flag byte	 */
-	unsigned char  pad_002;		/* Alignment			 */
-	unsigned short domain;		/* Domain			 */
-	unsigned char  pad_003[12];	/* Domain masks			 */
-	unsigned char  pad_004[36];	/* reserved			 */
-} __attribute__((packed));
-
 int zcrypt_pcixcc_init(void);
 void zcrypt_pcixcc_exit(void);
 
Index: quilt-2.6/include/asm-s390/zcrypt.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/zcrypt.h
+++ quilt-2.6/include/asm-s390/zcrypt.h
@@ -91,7 +91,7 @@ struct ica_rsa_modexpo_crt {
  *	    VUD block
  *	    key block
  */
-struct ica_CPRBX {
+struct CPRBX {
 	unsigned short	cprb_len;	/* CPRB length	      220	 */
 	unsigned char	cprb_ver_id;	/* CPRB version id.   0x02	 */
 	unsigned char	pad_000[3];	/* Alignment pad bytes		 */
@@ -130,7 +130,7 @@ struct ica_CPRBX {
 	unsigned char	cntrl_domain[4];/* Control domain		 */
 	unsigned char	S390enf_mask[4];/* S/390 enforcement mask	 */
 	unsigned char	pad_004[36];	/* reserved			 */
-};
+} __attribute__((packed));
 
 /**
  * xcRB

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
