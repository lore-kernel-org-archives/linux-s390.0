From: Thomas Huth <thuth@redhat.com>
Date: Mon, 25 Feb 2019 14:33:11 +0000
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Beautify sthyi report strings
Message-Id: <d8f3e60d-c9bd-d6eb-63e6-086703339e20@redhat.com>
In-Reply-To: <ce77130c-5cb9-97aa-88c7-9c0c2e0fe5ad@redhat.com>
References: <ce77130c-5cb9-97aa-88c7-9c0c2e0fe5ad@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 25/02/2019 15.27, David Hildenbrand wrote:
> On 25.02.19 15:22, Janosch Frank wrote:
>> On 25.02.19 13:54, Thomas Huth wrote:
>>> On 19/02/2019 09.49, Janosch Frank wrote:
>>>> Tests like the register odd check in r1 and r2 were not
>>>> destinguishable and the reports were hard to read in total.
>>>
>>> distinguishable
>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  s390x/sthyi.c | 45 +++++++++++++++++++++++++++++----------------
>>>>  1 file changed, 29 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/s390x/sthyi.c b/s390x/sthyi.c
>>>> index 16b8c14..aaf13af 100644
>>>> --- a/s390x/sthyi.c
>>>> +++ b/s390x/sthyi.c
>>>> @@ -52,10 +52,12 @@ static void test_exception_addr(void)
>>>>  
>>>>  static void test_exception_reg_odd(void)
>>>>  {
>>>> -	report_prefix_push("Register check odd");
>>>> +	report_prefix_push("Register check odd R1");
>>>>  	expect_pgm_int();
>>>>  	sthyi((uint64_t)pagebuf, 0, NULL, 1, 2);
>>>>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>>>> +	report_prefix_pop();
>>>> +	report_prefix_push("Register check odd R2");
>>>>  	expect_pgm_int();
>>>>  	sthyi((uint64_t)pagebuf, 0, NULL, 0, 3);
>>>>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>>>> @@ -76,52 +78,59 @@ static void test_function_code(uint64_t addr)
>>>>  	uint64_t urc = 0;
>>>>  	int cc = sthyi((uint64_t)pagebuf, 42, &urc, 0, 2);
>>>>  
>>>> -	report("Ill. fcode", cc == 3 && urc == CODE_UNSUPP);
>>>> +	report("Illegal fcode", cc == 3 && urc == CODE_UNSUPP);
>>>>  }
>>>>  
>>>>  static void test_fcode0_hdr(struct sthyi_hdr_sctn *hdr)
>>>>  {
>>>> -	report("HDR length", (hdr->INFHDLN >= sizeof(*hdr)
>>>> +	report_prefix_push("Header");
>>>> +
>>>> +	report("length", (hdr->INFHDLN >= sizeof(*hdr)
>>>>  			      && !(hdr->INFHDLN % 8)));
>>>
>>> That fits into one line now (especially if you also remove the redundant
>>> parentheses around the conditional expression).
>>
>> You and your hate for parentheses... :-)
>> Fixed all of the problems.
>>
> 
> Maybe he's traumatized by LISP ... just like me ;)

Yes, I took a LISP course at the university once ... I never overcame
that trauma... ;-)

 Thomas
