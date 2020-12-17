Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgLQO7Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 09:59:24 -0500
Date: Thu, 17 Dec 2020 15:55:30 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 8/8] s390x: Fix sclp.h style issues
Message-ID: <20201217155530.67922937@ibm-vm>
In-Reply-To: <20201211100039.63597-9-frankja@linux.ibm.com>
References: <20201211100039.63597-1-frankja@linux.ibm.com>
        <20201211100039.63597-9-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On Fri, 11 Dec 2020 05:00:39 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Fix indentation
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>m>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  lib/s390x/sclp.h | 172
> +++++++++++++++++++++++------------------------ 1 file changed, 86
> insertions(+), 86 deletions(-)
> 
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 58f8e54..dccbaa8 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -79,10 +79,10 @@
>  #define SCCB_SIZE 4096
>  
>  typedef struct SCCBHeader {
> -    uint16_t length;
> -    uint8_t function_code;
> -    uint8_t control_mask[3];
> -    uint16_t response_code;
> +	uint16_t length;
> +	uint8_t function_code;
> +	uint8_t control_mask[3];
> +	uint16_t response_code;
>  } __attribute__((packed)) SCCBHeader;
>  
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
> @@ -90,15 +90,15 @@ typedef struct SCCBHeader {
>  
>  /* CPU information */
>  typedef struct CPUEntry {
> -    uint8_t address;
> -    uint8_t reserved0;
> -    uint8_t : 4;
> -    uint8_t feat_sief2 : 1;
> -    uint8_t : 3;
> -    uint8_t features_res2 [SCCB_CPU_FEATURE_LEN - 1];
> -    uint8_t reserved2[6];
> -    uint8_t type;
> -    uint8_t reserved1;
> +	uint8_t address;
> +	uint8_t reserved0;
> +	uint8_t : 4;
> +	uint8_t feat_sief2 : 1;
> +	uint8_t : 3;
> +	uint8_t features_res2 [SCCB_CPU_FEATURE_LEN - 1];
> +	uint8_t reserved2[6];
> +	uint8_t type;
> +	uint8_t reserved1;
>  } __attribute__((packed)) CPUEntry;
>  
>  extern struct sclp_facilities sclp_facilities;
> @@ -110,77 +110,77 @@ struct sclp_facilities {
>  };
>  
>  typedef struct ReadInfo {
> -    SCCBHeader h;
> -    uint16_t rnmax;
> -    uint8_t rnsize;
> -    uint8_t  _reserved1[16 - 11];       /* 11-15 */
> -    uint16_t entries_cpu;               /* 16-17 */
> -    uint16_t offset_cpu;                /* 18-19 */
> -    uint8_t  _reserved2[24 - 20];       /* 20-23 */
> -    uint8_t  loadparm[8];               /* 24-31 */
> -    uint8_t  _reserved3[48 - 32];       /* 32-47 */
> -    uint64_t facilities;                /* 48-55 */
> -    uint8_t  _reserved0[76 - 56];       /* 56-75 */
> -    uint32_t ibc_val;
> -    uint8_t  conf_char[99 - 80];        /* 80-98 */
> -    uint8_t mha_pow;
> -    uint32_t rnsize2;
> -    uint64_t rnmax2;
> -    uint8_t  _reserved6[116 - 112];     /* 112-115 */
> -    uint8_t  conf_char_ext[120 - 116];   /* 116-119 */
> -    uint16_t highest_cpu;
> -    uint8_t  _reserved5[124 - 122];     /* 122-123 */
> -    uint32_t hmfai;
> -    uint8_t reserved7[134 - 128];
> -    uint8_t byte_134_diag318 : 1;
> -    uint8_t : 7;
> -    struct CPUEntry entries[0];
> +	SCCBHeader h;
> +	uint16_t rnmax;
> +	uint8_t rnsize;
> +	uint8_t  _reserved1[16 - 11];       /* 11-15 */
> +	uint16_t entries_cpu;               /* 16-17 */
> +	uint16_t offset_cpu;                /* 18-19 */
> +	uint8_t  _reserved2[24 - 20];       /* 20-23 */
> +	uint8_t  loadparm[8];               /* 24-31 */
> +	uint8_t  _reserved3[48 - 32];       /* 32-47 */
> +	uint64_t facilities;                /* 48-55 */
> +	uint8_t  _reserved0[76 - 56];       /* 56-75 */
> +	uint32_t ibc_val;
> +	uint8_t  conf_char[99 - 80];        /* 80-98 */
> +	uint8_t mha_pow;
> +	uint32_t rnsize2;
> +	uint64_t rnmax2;
> +	uint8_t  _reserved6[116 - 112];     /* 112-115 */
> +	uint8_t  conf_char_ext[120 - 116];   /* 116-119 */
> +	uint16_t highest_cpu;
> +	uint8_t  _reserved5[124 - 122];     /* 122-123 */
> +	uint32_t hmfai;
> +	uint8_t reserved7[134 - 128];
> +	uint8_t byte_134_diag318 : 1;
> +	uint8_t : 7;
> +	struct CPUEntry entries[0];
>  } __attribute__((packed)) ReadInfo;
>  
>  typedef struct ReadCpuInfo {
> -    SCCBHeader h;
> -    uint16_t nr_configured;         /* 8-9 */
> -    uint16_t offset_configured;     /* 10-11 */
> -    uint16_t nr_standby;            /* 12-13 */
> -    uint16_t offset_standby;        /* 14-15 */
> -    uint8_t reserved0[24-16];       /* 16-23 */
> -    struct CPUEntry entries[0];
> +	SCCBHeader h;
> +	uint16_t nr_configured;         /* 8-9 */
> +	uint16_t offset_configured;     /* 10-11 */
> +	uint16_t nr_standby;            /* 12-13 */
> +	uint16_t offset_standby;        /* 14-15 */
> +	uint8_t reserved0[24-16];       /* 16-23 */
> +	struct CPUEntry entries[0];
>  } __attribute__((packed)) ReadCpuInfo;
>  
>  typedef struct ReadStorageElementInfo {
> -    SCCBHeader h;
> -    uint16_t max_id;
> -    uint16_t assigned;
> -    uint16_t standby;
> -    uint8_t _reserved0[16 - 14]; /* 14-15 */
> -    uint32_t entries[0];
> +	SCCBHeader h;
> +	uint16_t max_id;
> +	uint16_t assigned;
> +	uint16_t standby;
> +	uint8_t _reserved0[16 - 14]; /* 14-15 */
> +	uint32_t entries[0];
>  } __attribute__((packed)) ReadStorageElementInfo;
>  
>  typedef struct AttachStorageElement {
> -    SCCBHeader h;
> -    uint8_t _reserved0[10 - 8];  /* 8-9 */
> -    uint16_t assigned;
> -    uint8_t _reserved1[16 - 12]; /* 12-15 */
> -    uint32_t entries[0];
> +	SCCBHeader h;
> +	uint8_t _reserved0[10 - 8];  /* 8-9 */
> +	uint16_t assigned;
> +	uint8_t _reserved1[16 - 12]; /* 12-15 */
> +	uint32_t entries[0];
>  } __attribute__((packed)) AttachStorageElement;
>  
>  typedef struct AssignStorage {
> -    SCCBHeader h;
> -    uint16_t rn;
> +	SCCBHeader h;
> +	uint16_t rn;
>  } __attribute__((packed)) AssignStorage;
>  
>  typedef struct IoaCfgSccb {
> -    SCCBHeader header;
> -    uint8_t atype;
> -    uint8_t reserved1;
> -    uint16_t reserved2;
> -    uint32_t aid;
> +	SCCBHeader header;
> +	uint8_t atype;
> +	uint8_t reserved1;
> +	uint16_t reserved2;
> +	uint32_t aid;
>  } __attribute__((packed)) IoaCfgSccb;
>  
>  typedef struct SCCB {
> -    SCCBHeader h;
> -    char data[SCCB_DATA_LEN];
> - } __attribute__((packed)) SCCB;
> +	SCCBHeader h;
> +	char data[SCCB_DATA_LEN];
> +} __attribute__((packed)) SCCB;
>  
>  /* SCLP event types */
>  #define SCLP_EVENT_ASCII_CONSOLE_DATA           0x1a
> @@ -195,13 +195,13 @@ typedef struct SCCB {
>  #define SCLP_SELECTIVE_READ                     0x01
>  
>  typedef struct WriteEventMask {
> -    SCCBHeader h;
> -    uint16_t _reserved;
> -    uint16_t mask_length;
> -    uint32_t cp_receive_mask;
> -    uint32_t cp_send_mask;
> -    uint32_t send_mask;
> -    uint32_t receive_mask;
> +	SCCBHeader h;
> +	uint16_t _reserved;
> +	uint16_t mask_length;
> +	uint32_t cp_receive_mask;
> +	uint32_t cp_send_mask;
> +	uint32_t send_mask;
> +	uint32_t receive_mask;
>  } __attribute__((packed)) WriteEventMask;
>  
>  #define MDBTYP_GO               0x0001
> @@ -254,25 +254,25 @@ struct mdb {
>  } __attribute__((packed));
>  
>  typedef struct EventBufferHeader {
> -    uint16_t length;
> -    uint8_t  type;
> -    uint8_t  flags;
> -    uint16_t _reserved;
> +	uint16_t length;
> +	uint8_t  type;
> +	uint8_t  flags;
> +	uint16_t _reserved;
>  } __attribute__((packed)) EventBufferHeader;
>  
>  typedef struct WriteEventData {
> -    SCCBHeader h;
> -    EventBufferHeader ebh;
> -    union {
> -	char data[0];
> -	struct mdb mdb;
> -    } msg;
> +	SCCBHeader h;
> +	EventBufferHeader ebh;
> +	union {
> +		char data[0];
> +		struct mdb mdb;
> +	} msg;
>  } __attribute__((packed)) WriteEventData;
>  
>  typedef struct ReadEventData {
> -    SCCBHeader h;
> -    EventBufferHeader ebh;
> -    uint32_t mask;
> +	SCCBHeader h;
> +	EventBufferHeader ebh;
> +	uint32_t mask;
>  } __attribute__((packed)) ReadEventData;
>  
>  extern char _sccb[];
