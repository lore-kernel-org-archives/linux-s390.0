From: Thomas Huth <thuth@redhat.com>
Date: Fri, 11 Jan 2019 09:49:56 +0000
Subject: Re: [kvm-unit-tests PATCH v5 08/11] s390x: Add linemode console
Message-Id: <104d9b4e-b982-da1e-ff93-2879e801e5b1@redhat.com>
In-Reply-To: <7ca1d33e-dc4d-6a4b-3623-f620193c3e19@redhat.com>
References: <7ca1d33e-dc4d-6a4b-3623-f620193c3e19@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2019-01-11 10:12, David Hildenbrand wrote:
> On 10.01.19 16:41, Janosch Frank wrote:
>> z/VM isn't fond of vt220, so we need line mode when running under z/VM.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/sclp-console.c | 181 ++++++++++++++++++++++++++++++++++++++++++-----
>>  lib/s390x/sclp.h         |  55 +++++++++++++-
>>  2 files changed, 218 insertions(+), 18 deletions(-)
>>
>> diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
>> index a5ef45f..3f97653 100644
>> --- a/lib/s390x/sclp-console.c
>> +++ b/lib/s390x/sclp-console.c
[...]
>> +static void sclp_print_lm(const char *str)
>> +{
>> +	unsigned char *ptr, *end, ch;
>> +	unsigned int count, offset, len;
>> +	struct WriteEventData *sccb;
>> +	struct mdb *mdb;
>> +	struct mto *mto;
>> +	struct go *go;
>> +
>> +	sclp_mark_busy();
>> +	sccb = (struct WriteEventData *) _sccb;
>> +	end = (unsigned char *) sccb + 4096 - 1;
>> +	memset(sccb, 0, sizeof(*sccb));
>> +	ptr = (unsigned char *) &sccb->msg.mdb.mto;
>> +	len = strlen(str);
>> +	offset = 0;
>> +	do {
>> +		for (count = sizeof(*mto); offset < len; count++) {
>> +			ch = str[offset++];
>> +			if ((ch == 0x0a) || (ptr + count > end))

Please drop the innermost parentheses here.

>> +				break;
>> +			ptr[count] = _ascebc[ch];
>> +		}
>> +		mto = (struct mto *) ptr;
>> +		mto->length = count;
>> +		mto->type = 4;
>> +		mto->line_type_flags = LNTPFLGS_ENDTEXT;
>> +		ptr += count;
>> +	} while (offset < len && ptr + sizeof(*mto) <= end);
>> +	len = ptr - (unsigned char *) sccb;
>> +	sccb->h.length = len - offsetof(struct WriteEventData, h);
>> +	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
>> +	sccb->ebh.type = EVTYP_MSG;
>> +	sccb->ebh.length = len - offsetof(struct WriteEventData, ebh);
>> +	mdb = &sccb->msg.mdb;
>> +	mdb->header.type = 1;
>> +	mdb->header.tag = 0xD4C4C240;
>> +	mdb->header.revision_code = 1;
>> +	mdb->header.length = len - offsetof(struct WriteEventData, msg.mdb.header);
>> +	go = &mdb->go;
>> +	go->length = sizeof(*go);
>> +	go->type = 1;
>> +	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>> +}
>> +
>> +/*
>> + * SCLP needs to be initialized by setting a send and receive mask,
>> + * indicating which messages the control program (we) want(s) to
>> + * send/receive.
>> + */
>>  static void sclp_set_write_mask(void)
>>  {
>>  	WriteEventMask *sccb = (void *)_sccb;
>>  
>>  	sclp_mark_busy();
>> +	memset(_sccb, 0, sizeof(*sccb));
>>  	sccb->h.length = sizeof(WriteEventMask);
>> -	sccb->mask_length = sizeof(unsigned int);
>> -	sccb->receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
>> -	sccb->cp_receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
>> -	sccb->send_mask = SCLP_EVENT_MASK_MSG_ASCII;
>> -	sccb->cp_send_mask = SCLP_EVENT_MASK_MSG_ASCII;
>> +	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
>> +	sccb->mask_length = sizeof(sccb_mask_t);
>> +
>> +	/* For now we don't process sclp input. */
>> +	sccb->cp_receive_mask = 0;
>> +	/* We send ASCII and line mode. */
>> +	sccb->cp_send_mask = SCLP_EVENT_MASK_MSG_ASCII | SCLP_EVENT_MASK_MSG;
>>  
>>  	sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
>> +	assert(sccb->h.response_code == SCLP_RC_NORMAL_COMPLETION);
>>  }
>>  
>>  void sclp_console_setup(void)
>> @@ -35,16 +179,19 @@ void sclp_console_setup(void)
>>  
>>  void sclp_print(const char *str)
>>  {
>> -	int len = strlen(str);
>> -	WriteEventData *sccb = (void *)_sccb;
>> -
>> -	sclp_mark_busy();
>> -	sccb->h.length = sizeof(WriteEventData) + len;
>> -	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
>> -	sccb->ebh.length = sizeof(EventBufferHeader) + len;
>> -	sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
>> -	sccb->ebh.flags = 0;
>> -	memcpy(sccb->data, str, len);
>> -
>> -	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>> +	/*
>> +	 * z/VM advertises a vt220 console which is not functional:
>> +	 * (response code 05F0, "not active because of the state of
>> +	 * the machine"). Hence testing the masks would only work if
>> +	 * we also use stsi data to distinguish z/VM.
>> +	 *
>> +	 * Let's rather print on all available consoles.
>> +	 */
>> +	if (strlen(str) > (1 << 11)) {
> 
> Or simply (PAGE_SIZE / 2), might be easier to get.

+1

 Thomas
